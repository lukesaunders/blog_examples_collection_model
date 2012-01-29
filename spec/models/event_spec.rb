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
end