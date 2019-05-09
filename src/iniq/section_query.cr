require "./line"

module Iniq
  class SectionQuery
    def initialize(@name : String)
      @in_section = !!@name.empty?
    end

    def match?(line)
      case line
      when Section
        @in_section = (line.name == @name)
        false
      else
        @in_section
      end
    end

    def process(stream)
      stream
        .each_line
        .select { |line| match?(line) }
        .each { |line| puts line }
    end
  end
end
