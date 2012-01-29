require 'spec_helper'

describe Event do
  describe "creation" do
    before(:each) do
      @base_params = FactoryGirl.attributes_for(:event)
    end

    context "valid" do
      subject { Event.new(@base_params) }
      it { should be_valid }
      it "should create quietly" do
        lambda { subject.save }.should_not raise_error
      end
    end
  end

  describe "jobs relation" do
    it { should have_many :jobs }
  end

  describe "nested attributes" do
    before do
      @params = FactoryGirl.attributes_for(:event)
      @params[:jobs_attributes] = [{:name => "created job one"}, {:name => "created job two"}]
    end

    subject { Event.new(@params) }

    it { should be_valid }
    it { should have(2).jobs }
  end
end