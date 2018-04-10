require 'iora'

RSpec.describe Iora do

  SOURCE_TYPE = :yaml
  SOURCE_ID = "data/test1.yml"

  let(:klas) { described_class }
  subject    { klas.new(SOURCE_TYPE, SOURCE_ID) }

  describe "Attributes" do
    it { should respond_to(:type) }
    it { should respond_to(:source) }
    it { should respond_to(:source_id) }
  end

  describe "Methods" do
    it { should respond_to(:issue) }
    it { should respond_to(:issues) }
  end

  describe "Construction" do
    it 'builds an object' do
      expect(subject).to_not be_nil
      expect(subject).to be_a(Iora)
    end

    it 'has proper attributes' do
      expect(subject.type).to eq(SOURCE_TYPE)
      expect(subject.source_id).to eq(SOURCE_ID)
    end

    it 'constructs a repo' do
      expect(subject.source).to_not be_nil
      expect(subject.source).to be_a(Source::Yaml)
    end

    it 'raises error on invalid type' do
      expect { klas.new(:bing, "bong") }.to raise_exception(IoraError::InvalidSourceType)
    end
  end
end
