require 'spec_helper'
require 'repo/github'

RSpec.describe Repo::Github do

  REPO_NAME = "andyl/iora"

  let(:klas) { described_class }
  subject    { klas.new(REPO_NAME) }

  describe "Attributes", USE_VCR do
    it { should respond_to(:repo_name) }
    it { should respond_to(:repo_data) }
  end

  describe "Methods", USE_VCR do
    it { should respond_to(:issues) }
    it { should respond_to(:issue) }
  end

  describe "Construction", USE_VCR do
    it 'builds an object' do
      expect(subject).to_not be_nil
      expect(subject).to be_a(klas)
    end

    it 'has proper attributes' do
      expect(subject.repo_name).to be_a(String)
      expect(subject.repo_data).to_not be_nil
      expect(subject.repo_data).to be_an(Array)
    end
  end

  describe "#issues", USE_VCR do
    it 'returns proper data' do
      expect(subject.issues.length).to eq(1)
    end
  end
end
