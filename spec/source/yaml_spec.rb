require 'source/yaml'

RSpec.describe Source::Yaml do

  DATA_FILE = "data/test1.yml"
  TMP_FILE = "/tmp/test1.yml"

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

    it 'creates datafile if it does not exist' do
      path = "/tmp/test_data.yml"
      `rm -f #{path}`
      klas.new(path)
      expect(File.exist?(path)).to eq(true)
    end
  end

  describe "#issues" do
    it 'returns proper data' do
      expect(subject.issues.length).to eq(4)
    end

    it 'has comments' do
      ii = subject.issues.last
      expect(ii["stm_comments"]).to_not be_nil
      expect(ii["stm_comments"]).to be_an(Array)
      expect(ii["stm_comments"].length).to eq(2)
    end
  end

  context "when writing" do
    before(:each) do
      `cp #{DATA_FILE} #{TMP_FILE}`
      @obj = klas.new(TMP_FILE)
    end

    describe "#create" do
      it "creates an issue" do
        expect(@obj.issues.length).to eq(4)
        @obj.create("TITLE1", "BODY1")
        expect(@obj.issues.length).to eq(5)
      end
    end

    describe "#update" do
      it "updates" do
        @obj.update(1, {"title" => "XXX"})
        expect(@obj.issues.first["stm_title"]).to eq("XXX")
      end
    end

    describe "#close" do
      it "closes" do
        @obj.close(1)
        expect(@obj.issues.first["stm_status"]).to eq("closed")
      end
    end

    describe "#open" do
      it "opens" do
        @obj.open(1)
        expect(@obj.issues.first["stm_status"]).to eq("open")
      end
    end

    describe "#create_comment" do
      it "creates comment" do
        @obj.create_comment(1, "HELLO")
        expect(@obj.issues.first["stm_comments"].first).to_not be_nil
        expect(@obj.issues.first["stm_comments"].first["issue_sequence"]).to eq(1)
        expect(@obj.issues.first["stm_comments"].first["body"]).to eq("HELLO")
      end
    end

    describe "#update_comment" do
      it "updates a comment" do
        @obj.create_comment(1, "HELLO")
        expect(@obj.issues.first["stm_comments"].first["body"]).to eq("HELLO")
        exid = @obj.issues.first["stm_comments"].first["exid"]
        @obj.update_comment(exid, "BING")
        expect(@obj.issues.first["stm_comments"].first).to_not be_nil
        expect(@obj.issues.first["stm_comments"].first["issue_sequence"]).to eq(1)
        expect(@obj.issues.first["stm_comments"].first["body"]).to eq("BING")
      end
    end
  end
end
