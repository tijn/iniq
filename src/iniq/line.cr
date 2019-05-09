require "./comment"
require "./property"
require "./section"

module Iniq
  class Line
    SECTION   = /\[(.*)\]/
    KEY_VALUE = /\s*(.*[^\s])\s*=\s*(.*[^\s])/
    COMMENT   = /\;(.*)/

    def self.parse(line)
      if line =~ SECTION
        Section.new $1.strip
      elsif line =~ KEY_VALUE
        Property.new $1, $2
      elsif line =~ COMMENT
        Comment.new $1.strip
      else
        nil # an empty line or some malformed property or so; we can ignore this
      end
    end
  end
end
