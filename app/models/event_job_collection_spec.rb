require 'spec_helper'

describe EventJobCollection do
  describe "new" do
    before do
      @event = Factory(:event)
    end

    context "without params" do
      before do
        @event_job_collection = EventJobCollection.new(@event)
      end

      subject { @event_job_collection }
      it { should be_a EventJobCollection }
      it { should respond_to :event }
      it { should respond_to :jobs }

      describe :jobs do
        before do
          @jobs = @event_job_collection.jobs
        end
        subject { @jobs }
        it { should be_an Array }
        it { should have(2).items }
      end
    end

    context "with hashed params, like from fields_for" do
      before do
        @params = {"jobs"=>{"0"=>{"name"=>"job 1", "event_id"=> @event.id, "expected_time" => "2.00"}, "1"=>{"name"=>"job 2", "event_id"=> @event.id, "expected_time" => "4.00"} } }
      end

      subject { EventJobCollection.new(@event, @params) }
      it { should be_a EventJobCollection }
      it { should have(2).jobs }

      it "should call new on Job with appropriate params" do
        mock_job = stub
        Job.should_receive(:new).once.with(@params["jobs"]["0"].symbolize_keys.merge(:event_id => @event.id, :done => false)).and_return(mock_job)
        Job.should_receive(:new).once.with(@params["jobs"]["1"].symbolize_keys.merge(:event_id => @event.id, :done => false)).and_return(mock_job)
        subject
      end
    end
  end

  describe "valid and save" do
    before do
      @event = Factory(:event)
    end
    context "valid params" do
      before do
        @params = {"jobs"=>[{"name"=>"job 1", "event_id"=> @event.id, "expected_time" => "2.00"}, {"name"=>"job 2", "event_id"=> @event.id, "expected_time" => "4.00"}]}
        @event_jobs = EventJobCollection.new(@event, @params)
      end
      subject { @event_jobs }

      it { should be_valid }

      it "should create the jobs" do
        lambda { subject.save }.should change(Job, :count).by(2)
      end

      it "should set jobs_finalized on event" do
        @event.should_receive(:jobs_finalized=).with(true).once
        @event.should_receive(:save).once
        subject.save
      end
    end
  end
end