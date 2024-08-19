# dynamic-SVG-from-Graphviz

2 versions exist in this repository:

1. javascript code that can be added to an SVG created by Graphviz to make it dynamic when opening in the browser (no library dependencies).
2. HTML version receiving dot source code rendering the graph locally using graphviz WASM library 

## 1.1 SVG Javascript Features

The following features are currently added:

-Highlighting: when nodes or edges are clicked they are highlighted. When clicking on a node all connecting edges are also highlighted, making it easier to trace them when there are many edges in a diagram

-zoom in or our on cluster: using the + or - button added to every cluster the drwaing is zooming in or out on the cluster.

The script is also adding a header section to the SVG with several features

-visibility switches: CSS classes can be added in grahviz dot to nodes or edges, all classes are listed in a button which will hide or show all nodes and edges with that class after clicking.

-(April 5th 2024) I am working on making a slider button that can be used to let items appear in the order defined by numerical CSS classes added to edges and nodes. numerical classes can be ordered integer, could be just 1,2,3,... or years. They are dynamically picked up. Will soon be released.

-(Aug 2024) I am working on the capability to collapse and expand clusters in drawings. But this will require a separate approach, as the complexity of redrawing diagrams requires the actual graphviz library to redraw the graph. Therefore i am working on a new approach whereby the dot src code is loaded in the browser, then the svg is produced by a local WASM library and the user interactions are first done on the dot src (graph object) before the new graph is then rendered using the graphviz WASM library.

## 1.2 SVG Javascript Usage 🛠️
Manual:

When you have an svg file generated by graphviz you need to edit the file and

change the svg opening tag by adding  onload="addInteractivity(evt)", giving something like:
```
<svg width="2056pt" height="2297pt" viewBox="0.00 0.00 2056.00 2297.00" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" onload="addInteractivity(evt)">
```
The content of the svg-script file should be added in front of the closing /svg tag.

Scripted:

 or use the script update-svg.sh
 dot -Tsvg -otransactions.svg transactions.dot && ../../dynamic-SVG-from-Graphviz/update-svg.sh transactions.svg

## 2. HTML version
This version takes a different approach, it loads the dot source code into a grap object using the graphlib-dot parser read method, applies changes to the graph object (highlight edges, collapse and expand clusters) and then writes the graph back to dot source code using the graphlib-dot write method and provides the new dot source code to the Grahviz WASM library.
libraries used
graphlibdot: https://github.com/dagrejs/graphlib-dot?tab=readme-ov-file
graphviz Wasm: https://github.com/hpcc-systems/hpcc-js-wasm/

features:
-node click: highlight edges
-cluster click collapse/expand cluster, redraw edges to collapsed node for cluster, collapse /expand all subclusters.
-facetted navigation (cluster tree is shown and classes are shown):
    -cluster collapse /Expand after applying filter
    -class hide:  remove/add all elements that have class from diagram
    -class highlight: highlight all elements on graph having class.
