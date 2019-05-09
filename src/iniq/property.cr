module Iniq
  class Property
    property :key, :value

    def initialize(@key : String, @value : String)
    end

    def to_s(io)
      io << "#{@key}=#{@value}"
    end
  end
end
