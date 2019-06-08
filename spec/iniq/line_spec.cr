require "../spec_helper"

describe Iniq::Line do
  describe ".parse" do
    it "recognizes a section" do
      Iniq::Line.parse("[foo]").should be_a(Iniq::Section)
    end

    it "recognizes comments" do
      Iniq::Line.parse("; comment").should be_a(Iniq::Comment)
    end

    it "recognizes key-value pairs" do
      Iniq::Line.parse("foo=bar").should be_a(Iniq::Property)
    end
  end
end
