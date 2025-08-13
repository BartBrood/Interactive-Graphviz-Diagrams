# Interactive Graphviz diagrams

    Last Update: 13th Aug 2025

Dynamic Graphviz graphs with collapsible and expandable clusters, edge highlighting through user clicks and graph subset filtering. Uses either CSV files or dot as a source.

2 versions exist in this repository:

1. HTML version, receiving dot source code and rendering the graph locally using Graphviz WASM library.

Test it here: https://graphinteract.com

2. JavaScript code that can be added to an SVG created by Graphviz to make it dynamic when opening in the browser (no library dependencies).

 ![image](https://github.com/user-attachments/assets/cbc4f07a-a681-4122-a597-71bc72e76818)


## 1.1 HTML version features
This page starts with loading the dot source code into a memory graph-object using the graphlib-dot parser read method. Once the graph-object is loaded dynamic changes are made to the graph object (highlight edges, collapse and expand clusters, filter). once the changes are applied to the graph-object it is transformed to dot source code using the graphlib-dot write method and provides the new dot source code to the Graphviz WASM library.
libraries used
graphlib-dot: https://github.com/dagrejs/graphlib-dot?tab=readme-ov-file
Graphviz WASM: https://github.com/hpcc-systems/hpcc-js-wasm/

features:

-load CSV files with nodes , edges and formatting from CSV format into dot syntax, select properties of nodes for being used as cluster, subcluster and class highlighters.

-zoom in and out when hovering over diagram use mouse wheel

-node click: highlight edges

-cluster click collapse/expand cluster, redraw edges to collapsed node for cluster, collapse /expand all subclusters.

-facetted navigation (cluster tree is shown and classes are shown):

-cluster collapse /Expand after applying filter
    
-class hide:  remove/add all elements that have class from diagram
-Numerical classes are separated in seperate section with a slider to allow show/hide order of nodes edges and clusters.
    
-class highlight: highlight all elements on graph having class.


## 1.2 HTML Interactive Graph Visualization Tool - Usage Guide

This tool allows you to visualize and interact with complex graph structures using a web interface. It supports file-based graph creation, faceted navigation, and various interactive features.

### Getting Started

1. Open the HTML file in a modern web browser.
2. You'll see a page with several sections: file input area, DOT source textarea, graph visualization area, and faceted navigation panel.

### Creating a Graph

#### Method 1: Using CSV Files

1. Click on "File Based Graph ▼" to expand the file input section.
2. Prepare three files: (see examples)
   - CSV Nodes file: Contains information about graph nodes.
   - CSV Edges file: Defines connections between nodes.
   - TXT Style file: Specifies visual styles for graph elements.
3. Click "Choose File" next to each input to select your prepared CSV files.
4. After selecting all files, click "Load files".
5. The tool will process your files and present the choice of how you want to cluster your data, select the properties to be used for cluster and subcluster and classes.
6. Press "Apply" and the tool will generate the dot source-code and the graph.

#### Method 2: Using DOT Source

1. In the "dot-src" textarea, enter or paste your graph definition in DOT language format.
2. Click "Update/Reset Graph" to render the graph based on your DOT source.

### Interacting with the Graph

- **Expand/Collapse Clusters**: Click on a cluster to toggle between expanded and collapsed states.
- **Highlight Connected Edges**: Click on a node to highlight its connected edges. Click again to remove highlighting.
- **Context Menu**: Right-click on a node to open a context menu with additional options:
  - Highlight Connected Edges
  - Filter Graph (shows only the selected node and its neighbors)

### Using Faceted Navigation

The faceted navigation panel on the left side of the interface allows you to filter and highlight graph elements:

1. **Expand/Collapse Clusters**: Use checkboxes to show or hide specific clusters and their subclusters.
2. **Hide/Highlight Numerical Classes**: Use the slider to filter nodes based on numerical classes. Adjust the slider to set the maximum visible class value.
3. **Hide/Highlight Categorical Classes**: Use checkboxes to show or hide nodes and edges with specific class attributes.
4. **Apply Filters**: After making your selections, click the "Apply Filter" button to update the graph visualization.

### Additional Features

- **Animation**: The graph renders with smooth animations for nodes and edges.
- **Responsive Layout**: The interface adjusts to different screen sizes for optimal viewing.

### Tips for Effective Use

1. Start with a small graph to familiarize yourself with the tool's features before working with larger, more complex graphs.
2. Use the faceted navigation to focus on specific parts of your graph when dealing with large datasets.
3. Experiment with different cluster structures and class attributes in your input files to leverage the full power of the filtering and highlighting features.
4. If your graph becomes too cluttered, use the cluster collapse feature or filtering options to simplify the view.

### Troubleshooting

- If the graph doesn't render correctly, check your DOT source or CSV files for syntax errors.
- Ensure your CSV files are properly formatted with the correct headers and data structure.
- If the browser becomes unresponsive with very large graphs, try simplifying your input or using the filtering options to reduce complexity.

By following this guide, you should be able to effectively use the interactive graph visualization tool to explore and analyze your graph data. Feel free to experiment with different inputs and interaction methods to get the most out of the tool!

## 2.1 SVG Javascript Features

This part describes the JavaScript code that can be added to an SVG created by Graphviz to make it dynamic when opening in the browser (no library dependencies).

The following features are currently added:

-Highlighting: when nodes or edges are clicked they are highlighted. When clicking on a node all connecting edges are also highlighted, making it easier to trace them when there are many edges in a diagram

-zoom in or out on cluster: using the + or - button added to every cluster the drawing is zooming in or out on the cluster.

The script is also adding a header section to the SVG with several features

-visibility switches: CSS classes can be added in Graphviz dot to nodes or edges, all classes are listed in a button which will hide or show all nodes and edges with that class after clicking.


## 2.2 SVG Javascript Usage 🛠️
Manual:

When you have an SVG file generated by Graphviz you need to edit the file and

change the SVG opening tag by adding  onload="addInteractivity(evt)", giving something like:
```
<svg width="2056pt" height="2297pt" viewBox="0.00 0.00 2056.00 2297.00" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" onload="addInteractivity(evt)">
```
The content of the svg-script file should be added in front of the closing /svg tag.

Scripted:

 or use the script update-svg.sh
```
 dot -Tsvg -otransactions.svg transactions.dot && ../../dynamic-SVG-from-Graphviz/update-svg.sh transactions.svg
```
