require 'spec_helper'

describe EventJobCollectionsController do
  describe "#new" do
    context "non-finalized event" do
      before do
        @event = Factory(:event, :jobs_finalized => false)
        get :new, :event_id => @event.id
      end

      it { should respond_with(:success) }
      it { should assign_to :event_job_collection }
      it { should render_template :new }
    end
  end

  describe "#create" do
    before do
      @event = Factory(:event)
      @params = {"jobs"=>{"0"=>{"event_id"=> "x"}, "1"=>{"event_id"=> "x"}}}
      Event.stub!(:find).with(@event.id.to_s).and_return(@event)
      @new_event_job_collection = mock
      EventJobCollection.should_receive(:new).with(@event, @params).and_return(@new_event_job_collection)
    end

    context "valid" do
      before do
        @new_event_job_collection.stub!(:valid?).and_return(true)
        @new_event_job_collection.should_receive(:save).once
        post :create, :event_job_collection => @params, :event_id => @event.id
      end
      it { should redirect_to event_path(@event.id) }
    end
  end
end
