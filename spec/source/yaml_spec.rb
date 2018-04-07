require 'source/yaml'

RSpec.describe Source::Yaml do

  DATA_FILE = "data/test1.yml"

  let(:klas) { described_class }
  subject    { klas.new(DATA_FILE) }

  describe "Attributes" do
    it { should respond_to(:data_file) }
    it { should respond_to(:repo_data) }
  end

  describe "Methods" do
    it { should respond_to(:issues) }
    it { should respond_to(:issue) }
  end

  describe "Construction" do
    it 'builds an object' do
      expect(subject).to_not be_nil
      expect(subject).to be_a(klas)
    end

    it 'has proper attributes' do
      expect(subject.data_file).to be_a(String)
      expect(subject.repo_data).to_not be_nil
      expect(subject.repo_data).to be_an(Array)
      expect(subject.repo_data.first).to be_a(Hash)
    end

    it 'raises error on invalid datafile' do
      expect { klas.new("bong") }.to raise_exception("File Not Found")
    end
  end

  describe "#issues" do
    it 'returns proper data' do
      expect(subject.issues.length).to eq(2)
    end
  end
end
