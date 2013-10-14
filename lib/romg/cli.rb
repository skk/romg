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

require 'mixlib/cli'

require 'romg/version' 
require 'romg/class_space' 
require 'romg/class_graph' 
require 'romg/class_graph/output/graphviz' 
require 'config'

module ROMG
  class CommandParser
    include Mixlib::CLI

    option :config_file, 
      short: "-c CONFIG",
      long: "--config CONFIG",
      default: 'config.rb',
      description: "The configuration file to use"

    option :log_level, 
      short: "-l LEVEL",
      long: "--log_level LEVEL",
      description: 
        "Set the log level: debug, info, warn, error, fatal (default)" ,
      required: false,
      default: :fatal,
      proc: Proc.new { |l| l.to_sym }

    option :version,
      short: "-v",
      long: "--version",
      description: "Gem version",
      boolean: true

    option :help,
      short: "-h",
      long: "--help",
      description: "Help",
      on: :tail,
      boolean: true,
      show_options: true,
      exit: 0
 end

 require 'pp'

 class CLI
  def self.execute
    cli = CommandParser.new
    cli.parse_options

    if cli.config[:version]
      puts "ROMG (Ruby Object Model Graph): #{ROMG::Version::VERSION}\n"
      exit 0
    end

    cs = ROMG::ClassSpace.new()
    cs.filter(CORE[:CLASSES])

    cg = ROMG::ClassGraph::ClassGraph.new(cs.class_list)
    cg.convert_class_list_to_graph()

    gv = ROMG::ClassGraph::Output::GraphViz.new(cg.graphviz)
    gv.output(File.absolute_path("romg.png"), "png", "dot")
    gv.output(File.absolute_path("romg.txt"), "plain", "dot")

    end
  end
end
