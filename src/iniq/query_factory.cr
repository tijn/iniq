module Iniq
  class QueryFactory
    def initialize(@query : Array(String))
    end

    def self.parse(query)
      new(query).to_query
    end

    def to_query
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

    private def section?(line)
      line =~ Line::SECTION
    end

    private def section_name(line)
      line[1, line.size - 2]
    end

    private def everything
      ERR.info "no query, showing all sections and values"
      Everything.new
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
      ERR.info "query for section and key"
      PropertyQuery.new(section_name(section), key)
    end

    private def section(query)
      ERR.info "query for section"
      name = section_name(query)
      SectionQuery.new(name)
    rescue error : KeyError
      raise KeyError.new("Missing section [#{name}]")
    end

    private def top_level_key(key)
      ERR.info "query for top level key"
      PropertyQuery.new("", key)
    end
  end
end
