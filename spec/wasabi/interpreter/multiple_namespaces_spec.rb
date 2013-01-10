require "spec_helper"

describe Wasabi::Interpreter do
  context "with: multiple_namespaces.wsdl" do

    subject(:interpreter) { new_interpreter(:multiple_namespaces) }

    it "knows the available types" do
      expect(interpreter).to have(2).types
      expect(interpreter.types).to include("Article", "Save")
    end

    it "knows the type namespaces from multiple schemas" do
      expect(interpreter.types["Article"]).to include(:namespace => "http://example.com/article")
      expect(interpreter.types["Save"]).to include(:namespace => "http://example.com/actions")
    end

    it "knows the types children" do
      expect(interpreter.types["Save"]).to include("article")
    end

    it "knows about multiple children" do
      expect(interpreter.types["Article"]).to include("Title", "Author")
    end

    it "knows the children's types" do
      expect(interpreter.types["Save"]["article"][:type]).to eq("article:Article")
      expect(interpreter.namespaces["xmlns:article"]).to eq("http://example.com/article")
    end

  end
end
