import xml.etree.ElementTree as ET
from xml.dom import minidom
import re
import os
import hashlib
import colorsys
import logging

# --- CONFIGURATION ---
# To focus on a single entity, provide its type and ID.
# To generate the full graph, set FOCUS_CONFIG = None.
# Example: FOCUS_CONFIG = {'type': 'device', 'id': '1234567890'}
FOCUS_CONFIG = {'type': 'RiskAssessmentTemplateQuestion', 'id': '267493767791038983'}
FOCUS_DEPTH = 3 # How many levels of relationships to show from the focus node.

# --- Setup Logging (UTF-8 safe) ---
log_filename = 'graph_generator.log'
if os.path.exists(log_filename):
    os.remove(log_filename)

logging.basicConfig(level=logging.INFO,
                    format='%(asctime)s - %(levelname)s - %(message)s',
                    handlers=[
                        logging.FileHandler(log_filename, encoding='utf-8'),
                        logging.StreamHandler()
                    ])

logging.info("Starting graph generation script...")
logging.info(f"Log file is being written to: {os.path.abspath(log_filename)}")


def get_color_for_string(s):
    """Generates a consistent, visually distinct color for a given string."""
    hash_val = int(hashlib.md5(s.encode('utf-8')).hexdigest(), 16)
    hue = (hash_val % 360) / 360.0
    lightness = 0.85
    saturation = 0.9
    rgb_float = colorsys.hls_to_rgb(hue, lightness, saturation)
    return '#{:02x}{:02x}{:02x}'.format(int(rgb_float[0] * 255),
                                     int(rgb_float[1] * 255),
                                     int(rgb_float[2] * 255))


def extract_xml_from_sql(sql_content):
    """Extracts the XML content from a T-SQL script variable."""
    match = re.search(r"DECLARE @XmlData XML = \s*'(.*?)';", sql_content,
                      re.DOTALL)
    if match:
        logging.info("Successfully extracted XML from SQL file.")
        return match.group(1)
    logging.warning("Could not find XML block in SQL file.")
    return None


def is_long_int(s):
    """Checks if a string represents a large integer, likely a unique ID."""
    if s is None or not isinstance(s, str):
        return False
    try:
        int(s)
        # Check if it contains non-digit characters (except a leading minus)
        # This helps distinguish IDs from version numbers like '11.9.23'
        return s.lstrip('-').isdigit() and abs(int(s)) > 1000
    except (ValueError, TypeError):
        return False


def get_best_label(elem, entity_type, pk_value):
    """Finds the best possible label for a node based on a prioritized list of attributes and tags."""
    label_candidates = [
        elem.get('displayLabel'),
        elem.get('description'),
        elem.get('name'),
        elem.get('systemName'),
        elem.findtext('./logical/[@label]'),
        elem.findtext('Name'),
        elem.findtext('Question'),
        elem.get('desc')
    ]
    # Find the first non-empty candidate
    label_text = next((candidate for candidate in label_candidates if candidate), None)

    if label_text:
        # Clean up and shorten long labels for display
        clean_label = re.sub(r'\s+', ' ', label_text).strip()
        display_label = f"{entity_type}\n{clean_label[:50]}{'...' if len(clean_label) > 50 else ''}"
    else:
        display_label = f"{entity_type}\n({pk_value})"

    return display_label


def get_primary_key(elem, entity_type):
    """Finds the primary key for an entity, prioritizing 'id' then 'type'."""
    pk_val = elem.get('id')
    if pk_val:
        return pk_val.strip()

    # Special case for lookup tables that use 'type' as a PK
    pk_val = elem.get('type')
    if pk_val:
        return pk_val.strip()

    # Fallback for legacy formats
    pk_tag_candidates = [
        f"{entity_type.capitalize()}ID", f"{entity_type.capitalize()}Id",
        f"{entity_type}ID", f"{entity_type}Id", "ID"
    ]
    for pk_tag in pk_tag_candidates:
        pk_val = elem.findtext(pk_tag)
        if pk_val:
            return pk_val.strip()

    return None


def find_and_create_edges(elem, source_node_id, source_pk_val, known_entity_types, name_to_id_map, edges):
    """Recursively finds and creates edges based on all discovered rules."""
    # Rule 1 & 4: Foreign Key by Attribute Name (ending in 'Id' or being 'type')
    for key, value in elem.attrib.items():
        if not value or value == source_pk_val:
            continue

        target_node_id = None
        target_type = None

        if key.lower().endswith('id') and is_long_int(value):
            target_type = re.sub(r'id$', '', key, flags=re.IGNORECASE)
            target_node_id = f"{target_type}_{value.strip()}"
        elif key.lower() == 'parentid' and is_long_int(value): # Specific case for parentId
            target_type = source_node_id.split('_')[0] # parent is same type as child
            target_node_id = f"{target_type}_{value.strip()}"
        elif key.lower() == 'type' and value.isdigit(): # Rule 4
            source_type = source_node_id.split('_')[0]
            target_type = f"{source_type}Type"
            target_node_id = f"{target_type}_{value.strip()}"

        if target_node_id:
            edges.append({'source': source_node_id, 'target': target_node_id, 'label': key})

    # Rule 3: Foreign Key by Name
    for key, value in elem.attrib.items():
        if key.lower() == 'cameraname':
            lookup_key = f"cameraName_{value.strip()}"
            if lookup_key in name_to_id_map:
                target_node_id = name_to_id_map[lookup_key]
                edges.append({'source': source_node_id, 'target': target_node_id, 'label': key})

    # Rule 2 & others: Nested Tags and Child Elements
    for child in elem:
        # Rule 2: Nested tag's 'id' is a foreign key
        if child.tag in known_entity_types and 'id' in child.attrib:
            target_type = child.tag
            target_pk = child.attrib['id']
            if is_long_int(target_pk):
                target_node_id = f"{target_type}_{target_pk.strip()}"
                edges.append({'source': source_node_id, 'target': target_node_id, 'label': f"{child.tag} (ref)"})

        # Rule 1 from child element text
        if child.tag.lower().endswith('id') and is_long_int(child.text):
            target_type = re.sub(r'id$', '', child.tag, flags=re.IGNORECASE)
            target_node_id = f"{target_type}_{child.text.strip()}"
            edges.append({'source': source_node_id, 'target': target_node_id, 'label': child.tag})

        # Recurse into container elements
        if len(child) > 0:
            find_and_create_edges(child, source_node_id, source_pk_val, known_entity_types, name_to_id_map, edges)


def generate_graph_from_files(file_paths, focus_config=None):
    """Parses a list of XML/SQL files to generate a GraphML string for yEd based on discovered rules."""
    nodes = {}
    edges = []
    name_to_id_map = {}
    known_entity_types = set()

    # --- PASS 1: Discover all nodes, types, and names ---
    logging.info("--- Pass 1: Discovering all nodes and names from all files ---")
    for file_path in file_paths:
        if not os.path.exists(file_path):
            logging.warning(f"File not found, skipping: {file_path}")
            continue

        logging.info(f"--- Analyzing for nodes: {file_path} ---")
        try:
            with open(file_path, 'r', encoding='utf-8-sig') as f:
                raw_content = f.read()

            xml_content = extract_xml_from_sql(raw_content) if file_path.lower().endswith('.sql') else raw_content

            if not xml_content or not xml_content.strip():
                logging.info(f"File is empty, skipping: {file_path}")
                continue

            root = ET.fromstring(xml_content)
            elements_to_process = list(root)

            for entity_elem in elements_to_process:
                entity_type = entity_elem.tag
                known_entity_types.add(entity_type)

                pk_value = get_primary_key(entity_elem, entity_type)
                if not pk_value:
                    continue

                node_id = f"{entity_type}_{pk_value}"
                if node_id in nodes:
                    continue # Already processed

                display_label = get_best_label(entity_elem, entity_type, pk_value)
                nodes[node_id] = {'label': display_label, 'type': entity_type}
                logging.info(f"  - Discovered Node '{node_id}' with label '{display_label.replace('\n', ' ')}'")

                # For Rule 3: Foreign Key by Name
                name_attr = entity_elem.get('name')
                if name_attr:
                    lookup_key = f"{entity_type}_{name_attr.strip()}"
                    name_to_id_map[lookup_key] = node_id
                    logging.info(f"    - Mapped name '{lookup_key}' to node '{node_id}'")

        except Exception as e:
            logging.error(f"Error during node discovery in {file_path}: {e}", exc_info=False)

    logging.info(f"\n--- Pass 1 Complete: {len(nodes)} nodes discovered. Known types: {sorted(list(known_entity_types))}")

    # --- PASS 2: Discover all relationships (edges) ---
    logging.info("\n--- Pass 2: Discovering all relationships (edges) ---")
    for file_path in file_paths:
        if not os.path.exists(file_path):
            continue

        logging.info(f"--- Analyzing for edges: {file_path} ---")
        try:
            with open(file_path, 'r', encoding='utf-8-sig') as f:
                raw_content = f.read()

            xml_content = extract_xml_from_sql(raw_content) if file_path.lower().endswith('.sql') else raw_content

            if not xml_content or not xml_content.strip():
                continue

            root = ET.fromstring(xml_content)
            elements_to_process = list(root)

            for entity_elem in elements_to_process:
                entity_type = entity_elem.tag
                pk_value = get_primary_key(entity_elem, entity_type)
                if not pk_value:
                    continue

                node_id = f"{entity_type}_{pk_value}"
                find_and_create_edges(entity_elem, node_id, pk_value, known_entity_types, name_to_id_map, edges)

        except Exception as e:
            logging.error(f"Error during edge discovery in {file_path}: {e}", exc_info=False)

    logging.info(f"\n--- Pass 2 Complete: {len(edges)} potential edges discovered.")

    # --- PASS 3: Filter for Focus Mode (if enabled) ---
    if focus_config and focus_config.get('type') and focus_config.get('id'):
        logging.info(f"\n--- Pass 3: Filtering graph to focus on {focus_config['type']} with ID {focus_config['id']} (depth: {FOCUS_DEPTH}) ---")
        focus_node_id = f"{focus_config['type']}_{focus_config['id']}"

        if focus_node_id not in nodes:
            logging.error(f"Focus entity {focus_node_id} not found. Showing full graph instead.")
        else:
            # Breadth-First Search to find all nodes within FOCUS_DEPTH
            nodes_to_keep = set()
            queue = [(focus_node_id, 0)]  # (node_id, depth)
            visited = {focus_node_id}

            while queue:
                current_node_id, current_depth = queue.pop(0)
                nodes_to_keep.add(current_node_id)

                if current_depth >= FOCUS_DEPTH:
                    continue

                # Find all neighbors of the current node
                for edge in edges:
                    neighbor_id = None
                    if edge['source'] == current_node_id:
                        neighbor_id = edge.get('target')
                    elif edge['target'] == current_node_id:
                        neighbor_id = edge.get('source')

                    if neighbor_id and neighbor_id not in visited:
                        visited.add(neighbor_id)
                        queue.append((neighbor_id, current_depth + 1))

            # Filter nodes and edges based on the BFS result
            nodes = {nid: ndata for nid, ndata in nodes.items() if nid in nodes_to_keep}
            for edge in edges:
                if not (edge['source'] in nodes_to_keep and edge['target'] in nodes_to_keep):
                    edges.remove(edge)
            logging.info(f"Focus mode applied. Resulting graph has {len(nodes)} nodes and {len(edges)} edges.")

    # --- PASS 4: Generate GraphML ---
    logging.info("\n--- Pass 4: Generating GraphML file ---")
    graphml_root = ET.Element("graphml", {
        "xmlns": "http://graphml.graphdrawing.org/xmlns",
        "xmlns:y": "http://www.yworks.com/xml/graphml",
        "xmlns:xsi": "http://www.w3.org/2001/XMLSchema-instance",
        "xsi:schemaLocation": "http://graphml.graphdrawing.org/xmlns http://graphml.graphdrawing.org/xmlns/1.0/graphml.xsd"
    })
    ET.SubElement(graphml_root, "key", {"id": "d_node_graphics", "for": "node", "yfiles.type": "nodegraphics"})
    ET.SubElement(graphml_root, "key", {"id": "d_edge_graphics", "for": "edge", "yfiles.type": "edgegraphics"})

    # Create placeholder nodes for any edge targets that were not explicitly defined
    all_node_ids = set(nodes.keys())
    for edge in edges:
        target_id = edge.get('target')
        if target_id and target_id not in all_node_ids:
            target_type, target_pk = target_id.split('_', 1)
            nodes[target_id] = {'label': f"{target_type}\n({target_pk})\n(Implicitly created)", 'type': target_type}
            all_node_ids.add(target_id)
            logging.warning(f"Created placeholder node for implicit target: {target_id}")

    graph = ET.SubElement(graphml_root, "graph", {"id": "G", "edgedefault": "directed"})

    entity_types = sorted(list(set(n['type'] for n in nodes.values())))
    color_map = {etype: get_color_for_string(etype) for etype in entity_types}

    for node_id, node_data in nodes.items():
        node_el = ET.SubElement(graph, "node", {"id": node_id})
        data_el = ET.SubElement(node_el, "data", {"key": "d_node_graphics"})
        shape_node = ET.SubElement(data_el, "y:ShapeNode")
        ET.SubElement(shape_node, "y:NodeLabel", {"alignment": "center", "autoSizePolicy": "content"}).text = node_data['label']
        ET.SubElement(shape_node, "y:Fill", {"color": color_map.get(node_data['type'], "#CCCCCC"), "transparent": "false"})
        ET.SubElement(shape_node, "y:BorderStyle", {"color": "#000000", "type": "line", "width": "1.0"})

    for i, edge_data in enumerate(edges):
        if edge_data['source'] in nodes and edge_data['target'] in nodes:
            edge_el = ET.SubElement(graph, "edge", {"id": f"e{i}", "source": edge_data['source'], "target": edge_data['target']})
            data_el = ET.SubElement(edge_el, "data", {"key": "d_edge_graphics"})
            line_edge = ET.SubElement(data_el, "y:PolyLineEdge")
            ET.SubElement(line_edge, "y:Arrows", {"source": "none", "target": "standard"})
            ET.SubElement(line_edge, "y:EdgeLabel").text = edge_data['label']

    rough_string = ET.tostring(graphml_root, 'utf-8')
    reparsed = minidom.parseString(rough_string)
    return reparsed.toprettyxml(indent="  ")

if __name__ == "__main__":
    files_to_process = [
        r'C:\Projects\Database\DeviceConfiguration\Scripts\DeploymentScripts\Data\DevicesData.xml',
        r'C:\Projects\Database\DeviceConfiguration\Scripts\DeploymentScripts\Data\EventsCameraData.xml',
        r'C:\Projects\Database\DeviceConfiguration\Scripts\DeploymentScripts\Data\EventsData.xml',
        r'C:\Projects\Database\DeviceConfiguration\Scripts\DeploymentScripts\Data\LinesData.xml',
        r'C:\Projects\Database\DeviceConfiguration\Scripts\DeploymentScripts\Data\ParametersData.xml',
        r'C:\Projects\Database\DeviceConfiguration\Scripts\DeploymentScripts\Data\PropertiesData.xml',
        r'C:\Projects\Database\DeviceConfiguration\Scripts\DeploymentScripts\Data\CameraDeviceInfo.xml',
        r'C:\Projects\Database\DeviceConfiguration\Scripts\DeploymentScripts\Data\DeviceScriptsData.xml',
        r'C:\Projects\Database\DeviceConfiguration\Scripts\DeploymentScripts\Data\LookupTablesData.xml',
        r'C:\Projects\Database\JourneyManagement\Scripts\PostDeployment\MergeRiskAssessmentTemplateQuestionData.sql',
    ]

    graphml_output = generate_graph_from_files(files_to_process, focus_config=FOCUS_CONFIG)

    output_filename = 'data_relationships.graphml'
    with open(output_filename, 'w', encoding='utf-8') as f:
        f.write(graphml_output)

    logging.info(f"\nSuccess! GraphML file '{output_filename}' has been created.")
    logging.info("You can now open this file with the yEd Graph Editor (desktop or web version).")
