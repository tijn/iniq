require "./line"

module Iniq
  class IniStream
    def initialize(@io : IO)
    end

    def self.open(filename : String)
      new(File.open(filename))
    end

    # returns an iterator that lazily parses each line
    def each_line
      @io.each_line.compact_map { |line| Line.parse(line) }
    end

    # yield each parsed line
    def each_line : Nil
      each_line.each { |line| yield line }
    end
  end
end
