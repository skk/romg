# encoding: utf-8

# Copyright (c) 2013 Steven K. Knight

# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:

# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

require 'graphviz'

module ROMG

  module ClassGraph

    class ClassGraph
      attr_reader :class_list
      attr_reader :graphviz

      def initialize(class_list)
        @class_list = class_list
        @graphviz = ::GraphViz.new("ROMG")
        @edges_cache = {}
      end

      def graph_add_or_find_node(c)
          node = @graphviz.find_node(c.name)
          if node == nil
            node = @graphviz.add_node(c.name)
          end
          node
      end

      # ensure that only 1 edge is shown from parent to child
      def add_edge_to_cache(head_node, tail_node)
        @edges_cache[head_node] = {} if @edges_cache[head_node] == nil
        if @edges_cache[head_node][tail_node] == nil
          @edges_cache[head_node][tail_node] = 1
          @graphviz.add_edge(head_node, tail_node)
        end
      end

      def process_ancestor_list(ancestors, head_node)
        ancestors.each do |a|
          tail_node = graph_add_or_find_node(a)
          add_edge_to_cache(head_node, tail_node)
          head_node = tail_node
        end
      end

      # remove the reference to c in the ancestors list
      # irb > String.ancestors
      # => [String, Comparable, Object, Kernel, BasicObject] 
      # as you can see String is a ancestors to itself!
      def generate_ancestor_list(c)
       c.ancestors.find_all { |a| a != c }
      end

      # TODO: rename to 'to_graph' ??
      def convert_class_list_to_graph()
        class_list.each do |c|
          node = graph_add_or_find_node(c)
          ancestors = generate_ancestor_list(c)
          process_ancestor_list(ancestors, node)
        end
      end
    end
  end
end