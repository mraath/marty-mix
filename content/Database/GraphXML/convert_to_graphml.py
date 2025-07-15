import xmltodict
from xml.etree.ElementTree import Element, SubElement, tostring
from xml.dom import minidom

class Node:
    def __init__(self, id, label, entity_type=None):
        self.id = id
        self.label = label
        self.entity_type = entity_type

class Edge:
    def __init__(self, source, target, label):
        self.source = source
        self.target = target
        self.label = label

class Graph:
    def __init__(self):
        self.nodes = []
        self.edges = []
        self.node_ids = set()
    
    def add_node(self, node):
        if node.id not in self.node_ids:
            self.node_ids.add(node.id)
            self.nodes.append(node)
    
    def add_edge(self, edge):
        self.edges.append(edge)
    
    def to_graphml(self):
        # Create root element with proper namespaces
        graphml = Element('graphml', {
            'xmlns': "http://graphml.graphdrawing.org/xmlns",
            'xmlns:xsi': "http://www.w3.org/2001/XMLSchema-instance",
            'xsi:schemaLocation': "http://graphml.graphdrawing.org/xmlns http://graphml.graphdrawing.org/xmlns/1.1/graphml.xsd"
        })
        
        # Define keys for node and edge attributes
        key_attrs = [
            {'id': 'label', 'for': 'node', 'attr.name': 'label', 'attr.type': 'string'},
            {'id': 'type', 'for': 'node', 'attr.name': 'type', 'attr.type': 'string'},
            {'id': 'edge_label', 'for': 'edge', 'attr.name': 'label', 'attr.type': 'string'}
        ]
        
        for attrs in key_attrs:
            SubElement(graphml, 'key', attrs)
        
        # Create graph element
        graph = SubElement(graphml, 'graph', {'id': 'G', 'edgedefault': 'directed'})
        
        # Add nodes with original IDs and labels
        for node in self.nodes:
            node_elem = SubElement(graph, 'node', id=str(node.id))
            label_data = SubElement(node_elem, 'data', key='label')
            label_data.text = node.label
            type_data = SubElement(node_elem, 'data', key='type')
            type_data.text = node.entity_type if node.entity_type else 'unknown'
        
        # Add edges with labels
        for i, edge in enumerate(self.edges):
            # Use original IDs for source and target
            source_id = edge.source
            target_id = edge.target
            
            edge_elem = SubElement(graph, 'edge', {
                'id': f'e{i}', 
                'source': str(source_id), 
                'target': str(target_id)
            })
            label_data = SubElement(edge_elem, 'data', key='edge_label')
            label_data.text = edge.label
        
        # Return pretty-printed XML
        rough = tostring(graphml, 'utf-8')
        parsed = minidom.parseString(rough)
        return parsed.toprettyxml(indent='  ')

def convert_xml_to_graphml(xml_files):
    graph = Graph()
    node_ids = set()
    
    # Process each XML file with debugging
    for file in xml_files:
        try:
            print(f"\nProcessing {file}")
            with open(file, 'r', encoding='utf-8-sig') as f:
                content = f.read()
                print(f"File size: {len(content)} characters")
                
                # Parse XML and show root keys
                data = xmltodict.parse(content)
                root_keys = list(data.keys())
                print(f"Root keys: {root_keys}")
                
                # Extract entities and relationships
                for root_key, root_value in data.items():
                    print(f"Processing root key: {root_key}")
                    
                    # Recursively extract entities from nested structures
                    def process_entity(entity, entity_type=None):
                        # Create node for each entity with an ID
                        node_id = entity.get('id') or entity.get('@id')
                        if node_id:
                            # Only add node if it hasn't been added before
                            if node_id not in node_ids:
                                label = entity.get('name') or entity.get('description') or entity_type or root_key
                                graph.add_node(Node(node_id, label, entity_type))
                                print(f"Added node: {node_id} ({label})")
                                node_ids.add(node_id)
                        
                        # Create relationships
                        if 'dependencies' in entity:
                            deps = entity['dependencies']
                            if not isinstance(deps, list):
                                deps = [deps]
                            print(f"Found {len(deps)} dependencies")
                            
                            for dep in deps:
                                target = dep.get('parentId') or dep.get('@parentId')
                                if target and node_id:
                                    graph.add_edge(Edge(node_id, target, 'depends_on'))
                                    print(f"Added edge: {node_id} -> {target} (depends_on)")
                        
                        if 'lines' in entity:
                            lines = entity['lines']
                            if not isinstance(lines, list):
                                lines = [lines]
                            print(f"Found {len(lines)} lines")
                            
                            for line in lines:
                                target = line.get('lineId') or line.get('@lineId')
                                if target and node_id:
                                    graph.add_edge(Edge(node_id, target, 'has_line'))
                                    print(f"Added edge: {node_id} -> {target} (has_line)")
                        
                        # Recursively process nested entities
                        for key, value in entity.items():
                            if key not in ['dependencies', 'lines']:  # Skip already processed
                                if isinstance(value, dict):
                                    process_entity(value, key)
                                elif isinstance(value, list):
                                    for item in value:
                                        if isinstance(item, dict):
                                            process_entity(item, key)
                    
                    # Process the root value
                    if isinstance(root_value, dict):
                        process_entity(root_value, root_key)
                    elif isinstance(root_value, list):
                        for item in root_value:
                            if isinstance(item, dict):
                                process_entity(item, root_key)
        except Exception as e:
            print(f"Error processing {file}: {str(e)}")
            continue

    return graph

# List your XML files
xml_files = [
    'DeviceConfiguration/Scripts/DeploymentScripts/Data/DevicesData.xml',
    'DeviceConfiguration/Scripts/DeploymentScripts/Data/EventsData.xml',
    'DeviceConfiguration/Scripts/DeploymentScripts/Data/LinesData.xml',
    'DeviceConfiguration/Scripts/DeploymentScripts/Data/ParametersData.xml',
    'DeviceConfiguration/Scripts/DeploymentScripts/Data/PropertiesData.xml'
]

# Generate GraphML
graph = convert_xml_to_graphml(xml_files)
with open('device_graph.graphml', 'w') as f:
    f.write(graph.to_graphml())
