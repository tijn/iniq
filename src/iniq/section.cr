module Iniq
  class Section
    property :name

    def initialize(@name : String)
    end

    def to_s(io)
      io << "[#{@name}]"
    end
  end
end
