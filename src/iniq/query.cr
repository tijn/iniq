module Iniq
  class Query
    def initialize(@ini : Hash(String, Hash(String, String)), @query : Array(String))
      @ini[""] ||= {} of String => String # the top level non-section must always exist
    end

    def perform
      case @query.size
      when 0
        everything
      when 1
        section_or_key
      when 2
        section_plus_key
      else
        raise KeyError.new("too many queries")
      end
    end

    private def section?(string)
      string.starts_with?('[') && string.ends_with?(']')
    end

    private def section_name(string)
      string[1, string.size - 2]
    end

    private def everything
      Writer.new(@ini)
    end

    private def section_or_key(query = @query.first)
      if section?(query)
        section(query)
      else
        top_level_key(query)
      end
    end

    private def section_plus_key(section = @query.first, key = @query.last)
      raise KeyError.new("#{section} needs square [brackets]") unless section?(section)
      @ini[section_name(section)][key]
    end

    private def section(query)
      name = section_name(query)
      values = @ini[name]
      Writer.simple(values)
    rescue error : KeyError
      raise KeyError.new("Missing section [#{name}]")
    end

    def top_level_key(key)
      @ini[""][key]
    end
  end
end
