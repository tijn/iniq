module Iniq
  class Comment
    property :text

    def initialize(@text : String)
    end

    def to_s(io)
      io << "; #{@text}".colorize(:light_gray).mode(:dim)
    end
  end
end
