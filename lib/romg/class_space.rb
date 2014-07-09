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

module ROMG

  class ClassSpace
    include Enumerable

    attr_reader :class_list

    def initialize()
        @class_list = ObjectSpace.each_object(Class).to_a
    end

    # should this really by mutating @class_list ?
    def filter(valid_class_list)
      @class_list = @class_list.find_all do |c| 
        #puts "c #{c}\n in valid_class_list #{valid_class_list.include?(c)}\n"
        valid_class_list.include?(c)
      end
    end

    def each()
      @class_list.each { |c| yield c }
    end

  end
end