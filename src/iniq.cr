require "./iniq/*"
require "ini"
require "option_parser"

module Iniq
  OPTIONS = Options.parse!

  def self.info(*string)
    STDERR.puts *string if OPTIONS.verbose?
  end

  def self.read_input
    if STDIN.tty?
      info "reading #{OPTIONS.filename}"
      File.read(OPTIONS.filename)
    else
      info "reading from stdin"
      contents = [] of String
      while s = STDIN.gets
        contents << s
      end
      contents.join("\n")
    end
  end

  def self.read_ini
    INI.parse(read_input)
  end

  def self.perform_query
    ini = read_ini
    puts Query.new(ini, OPTIONS.query).perform
  rescue error : KeyError
    info error.to_s.gsub(" hash key", " key")
    exit OPTIONS.not_found_status
  end

  perform_query
end
