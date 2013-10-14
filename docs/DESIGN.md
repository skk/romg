
Ruby Object Model Graph
=======================


Goals
-----

Provide an easy to use program to create graphs [1] of the various classes in Ruby and your applications.

Implementation Plan
-------------------

1) Obtain list of all classes to the Ruby.

2) Filter this list and remove classes the user wishes to ignore.

3) Construct graph from the filtered list.

4) Convert graph to the requested output format (Graphviz, etc).


Details
-------

This project will contain the following classes:

ClassSpace -> This class will generate list of classes and filter this list.  (Steps 1 & 2)

ClassGraph -> This class will turn the (filtered) list of classes into a graph.

ClassGraph::Output::GraphViz -> This class will turn the class graph into a graphviz file.


[1]: By graph I mean "a graph is a representation of a set of objects where some pairs of objects are connected by links." From http://en.wikipedia.org/wiki/Graph_(mathematics).
