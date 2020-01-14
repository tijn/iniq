module Iniq
  class Section
    property :name

    def initialize(@name : String)
    end

    def to_s(io)
      io << "[#{name}]".colorize(:cyan).mode(:bold)
    end
  end
end
