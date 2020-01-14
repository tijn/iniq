module Iniq
  class Options
    property :not_found_status, :verbose, :filename, :query

    def initialize
      @not_found_status = 0
      @verbose = false
      @filename = ""
      @query = [] of String
    end

    def verbose?
      @verbose
    end

    def self.parse!
      options = Options.new
      OptionParser.parse do |parser|
        parser.banner =
          "Usage: iniq [OPTION]... INI-FILE KEY\n" \
          "       iniq [OPTION]... INI-FILE \"[SECTION]\" KEY\n" \
          "       iniq [OPTION]... INI-FILE \"[SECTION]\"\n" \
          "       cat INI-FILE | iniq [OPTION]... [\"[SECTION]\"] KEY\n" \
          "\n" \
          "  Query an INI file for a value using a key and maybe a section.\n" \
          "\n" \
          "  Grab a whole section by providing its name within square brackets. The special\n" \
          "  section \"[]\" refers to the keys that have no section. Sections are printed\n" \
          "  as INI files that can be parsed (by iniq) again. Comments will be stripped.\n" \
          "\n" \
          "Examples:\n" \
          "       $ iniq /usr/lib/firefox/application.ini \"[App]\" Version\n" \
          "       56.0.1\n" \
          "       $ iniq /usr/lib/firefox/application.ini \"[Gecko]\"\n" \
          "       MinVersion=56.0.1\n" \
          "       MaxVersion=56.0.1\n" \
          "       $ iniq test.ini \"[App]\" | iniq Version\n" \
          "       56.0.1\n"

        parser.on("-e", "--exit-status", "Exit with a non-zero status if value cannot be found") do
          options.not_found_status = 4
        end

        parser.on("-h", "--help", "Display this screen") do
          STDERR.puts parser
          exit
        end

        parser.on("-v", "--verbose", "Verbose output") do
          options.verbose = true
        end
      end
      options.filename = fetch_filename!
      options.query = ARGV
      return options
    rescue error : OptionParser::InvalidOption
      ERR.error error
      exit 1
    end

    private def self.fetch_filename!
      STDIN.tty? ? ARGV.shift : ""
    rescue IndexError
      ERR.error "no input given"
      exit 1
    end
  end
end
