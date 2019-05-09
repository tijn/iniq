require "./iniq/*"
require "ini"
require "option_parser"

module Iniq
  OPTIONS = Options.parse!
  ERR.progname = "iniq"
  ERR.level = Logger::Severity::WARN

  def self.input
    if STDIN.tty?
      ERR.info "reading #{OPTIONS.filename}"
      IniStream.open(OPTIONS.filename)
    else
      ERR.info "reading from stdin"
      IniStream.new(STDIN)
    end
  end

  def self.query(q = OPTIONS.query)
    QueryFactory.parse(q)
  end

  def self.perform_query
    query.process(input)
  rescue error : KeyError
    ERR.error error.to_s.gsub(" hash key", " key")
    exit OPTIONS.not_found_status
  end

  perform_query
end
