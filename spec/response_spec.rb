require "spec_helper"

describe Alephant::Renderer::Response do
  subject { described_class.new content }
  let(:content) { "<h1>foo</h1>" }

  describe "#to_json" do
    specify do
      expected_structure = { "content" => content }

      expect(JSON.parse subject.to_json).to eq expected_structure
    end
  end
end

