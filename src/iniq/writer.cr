module Iniq
  class Writer
    def initialize(@hash : Hash(String, Hash(String, String)))
    end

    def self.simple(hash : Hash(String, String))
      new({"" => hash})
    end

    def to_s(io : IO)
      newline = false
      if unsectioned?
        unsectioned.each do |key, value|
          io << "\n" if newline
          io << "#{key}=#{value}"
          newline = true
        end
      end
      section_names.each do |section_name|
        io << "\n\n" if newline
        newline = true
        io << "[#{section_name}]"
        @hash[section_name].each do |key, value|
          io << "\n#{key}=#{value}"
        end
      end
    end

    def unsectioned?
      @hash.has_key?("")
    end

    def unsectioned
      @hash[""]
    end

    def section_names
      @hash.keys - [""]
    end
  end
end
