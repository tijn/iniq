require "./line"

module Iniq
  class PropertyQuery
    def initialize(@section : String, @key : String)
      @current_section = ""
    end

    def value(line)
      case line
      when Section
        @current_section = line.name
        nil
      when Property
        line.value if @current_section == @section && line.key == @key
      end
    end

    def process(stream)
      stream
        .each_line
        .compact_map { |line| value(line) }
        .each { |value| puts value }
    end
  end
end
