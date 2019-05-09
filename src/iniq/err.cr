require "logger"

module Iniq
  class Err
    FORMATTER = Logger::Formatter.new do |_severity, _datetime, progname, message, io|
      io << progname << ": " << message
    end

    delegate progname, level, debug, info, warn, error, fatal, to: @logger

    def initialize(io : IO = STDERR)
      @logger = Logger.new(io)
      @logger.formatter = FORMATTER
      @logger.level = Logger::Severity::WARN
    end

    def progname=(name)
      @logger.progname = name
    end

    def level=(level)
      @logger.level = level
    end

    def debug(*messages)
      messages.each { |message| @logger.debug(message) }
    end

    def info(*messages)
      messages.each { |message| @logger.info(message) }
    end

    def warn(*messages)
      messages.each { |message| @logger.warn(message) }
    end

    def error(*messages)
      messages.each { |message| @logger.error(message) }
    end

    def fatal(*messages)
      messages.each { |message| @logger.fatal(message) }
    end
  end

  ERR = Err.new
end
