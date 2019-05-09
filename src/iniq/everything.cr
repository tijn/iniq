require "./line"

module Iniq
  class Everything
    def process(stream)
      first_line = true
      stream.each_line do |line|
        puts if !first_line && line.is_a? Section
        puts line
        first_line = false
      end
    end
  end
end
