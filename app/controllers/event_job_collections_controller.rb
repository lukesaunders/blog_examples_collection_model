class EventJobCollectionsController < ApplicationController
  before_filter :grab_event_from_id

  def new
    raise_error if @event.jobs_finalized?
    @event_job_collection = EventJobCollection.new(@event)
  end

  def create
    event_job_collection = EventJobCollection.new(@event, params["event_job_collection"])
    if event_job_collection.valid?
      event_job_collection.save
      redirect_to event_path(@event)
    else
      render :new
    end
  end

  private
  def grab_event_from_id
    @event = Event.find(params[:event_id])
  end
end
