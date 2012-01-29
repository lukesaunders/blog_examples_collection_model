require 'spec_helper'

describe Job do
  describe "creation" do
    before(:each) do
      @base_params = FactoryGirl.attributes_for(:job)
    end

    context "valid" do
      subject { Job.new(@base_params) }
      it { should be_valid }
      it "should create quietly" do
        lambda { subject.save }.should_not raise_error
      end
    end
  end
end