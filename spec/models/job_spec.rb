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

  describe "template_jobs" do
    subject { Job.template_jobs }

    it { should be_an Array }

    it "have the right names" do
      subject.map(&:name).should == ["Erect a flag pole", "Raise the flag"]
    end
  end
end