require 'iora'

RSpec.describe Iora do

  REPO_TYPE = :yaml
  REPO_ID = "data/test1.yml"

  let(:klas) { described_class }
  subject    { klas.new(REPO_TYPE, REPO_ID) }

  describe "Attributes" do
    it { should respond_to(:type) }
    it { should respond_to(:repo) }
    it { should respond_to(:repo_id) }
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
      expect(subject.type).to eq(REPO_TYPE)
      expect(subject.repo_id).to eq(REPO_ID)
    end

    it 'constructs a repo' do
      expect(subject.repo).to_not be_nil
      expect(subject.repo).to be_a(Repo::Yaml)
    end

    it 'raises error on invalid type' do
      expect { klas.new(:bing, "bong") }.to raise_exception("Invalid Repo Type")
    end
  end
end
