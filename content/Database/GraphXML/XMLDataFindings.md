# XML Data Structure Findings for Graph Generation

This document outlines the rules and patterns discovered from analyzing the various XML data files. The purpose is to inform the logic of the `generate_yed_graph.py` script, which creates a visual relationship graph of the data.

## 1. Core Objective

The primary goal is to parse a set of XML and SQL files to identify all data entities and visualize their relationships as a directed graph in the yEd Graph Editor.

## 2. Entity & Primary Key (PK) Identification

-   **Entity:** An entity is a primary data object, typically represented by a singular XML tag (e.g., `<device>`, `<event>`, `<line>`). The tag name itself defines the entity's `type`.
-   **Primary Key:** Each entity instance has a unique identifier which serves as its Primary Key.
    -   The PK is found in an attribute or child element, usually named `id` or `<EntityType>Id` (e.g., `id`, `deviceId`, `eventId`).
    -   For top-level entities like `<device id="...">`, the `id` attribute is the PK.
    -   The script generates a unique `node_id` for the graph by combining the entity type and its PK (e.g., `device_6183...`).

## 3. Node Labeling Strategy

To ensure the graph is readable, nodes are labeled using the best available human-readable name. The script searches for the following attributes or child elements in this order of priority:

1.  `displayLabel` attribute (e.g., in `PropertiesData.xml`)
2.  `description` attribute (e.g., in `DevicesData.xml`, `EventsData.xml`)
3.  `name` attribute (e.g., in `LinesData.xml`, `CameraDeviceInfo.xml`)
4.  `systemName` attribute (e.g., in `DevicesData.xml`)
5.  `label` attribute of a `<logical>` child element (e.g., in `DevicesData.xml`)
6.  Text content of a `<Name>` or `<Question>` child element.
7.  `desc` attribute (e.g., in `LinesData.xml`)

If no label is found, the node will be labeled with its type and ID.

## 4. Relationship (Foreign Key) Finding Rules

The script must use a multi-pass process to first map all entities and their keys, then establish the links based on the following four patterns.

### Rule 1: Foreign Key by Attribute Name

-   **Pattern:** An attribute whose name ends in `Id` or `Key` (e.g., `deviceId`, `lineId`, `parameterId`, `parentId`).
-   **Value:** The attribute's value must be a long integer.
-   **Target Type Inference:** The target entity type is derived from the attribute name by stripping `Id`, `ID`, or `Key` from the end (e.g., `deviceId` -> `device`).
-   **Examples:**
    -   `<transport ... deviceId="-7101...">` in `DevicesData.xml` links to a `device`.
    -   `<dependency ... parentId="-7101...">` in `DevicesData.xml` links to another `device` (a self-reference).
    -   `<event ... returnParameterId="...">` in `EventsData.xml` links to a `parameter`.

### Rule 2: Foreign Key by Nested Tag

-   **Pattern:** When an entity tag is found *nested inside another entity*, its `id` attribute is treated as a **foreign key**.
-   **Context is Key:** The script must differentiate between a top-level entity definition and a nested reference.
-   **Example:**
    -   In `PropertiesData.xml`, `<property id="...">` is a primary entity definition.
    -   In `DevicesData.xml`, a `<property id="..." name="...">0</property>` nested inside a `<device>` is a **link**. The `id` attribute here is a foreign key to the `property` entity. This pattern also applies to nested `<line>`, `<parameter>`, and `<event>` tags.

### Rule 3: Foreign Key by Name (Text-based link)

-   **Pattern:** An attribute whose value is a string that matches the `name` attribute of another entity.
-   **Example:** In `CameraDeviceInfo.xml`, `<deviceChannel ... cameraName="Road">` links to the `<cameraName ... name="Road"/>` entity.
-   **Implementation:** This requires a "name-to-ID" map to be built during the first pass, so the text-based name can be resolved to the correct target `node_id`.

### Rule 4: Foreign Key by `type` Attribute (Lookup Tables)

-   **Pattern:** An attribute named `type` on a primary entity.
-   **Target Type Inference:** The target entity is the source tag name with "Type" appended.
-   **Example:** In `DevicesData.xml`, a `<device ... type="130">` links to the `<deviceType type="130">` entity found in `LookupTablesData.xml`.

## 5. File Handling

-   The script must process all `.xml` files in the specified list.
-   It must also handle `.sql` files by extracting the XML content from the `DECLARE @XmlData XML = '...'` block.

## 6. Special Cases & Complexities

-   **Recursive Search:** The script must recursively search through nested container tags (e.g., `<lines>`, `<dependencies>`, `<parameters>`) to find all links.
-   **Implicit Node Creation:** If an edge points to a node ID that hasn't been explicitly defined in any file (a "dangling reference"), the script should create a placeholder node for it to make the graph complete and highlight missing data.
