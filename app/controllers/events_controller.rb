class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def edit
    @event = Event.find(params[:id])

    unless @event.jobs_finalized?
      @new_jobs = Job.template_jobs
    end
  end

  def create
    @event = Event.new(params[:event])

    if @event.save
      flash[:notice] = 'Event was successfully created'
      redirect_to @event, notice: 'Event was successfully created.'
    else
      render :action => :new
    end
  end

  def update
    @event = Event.find(params[:id])

    @event.attributes = params[:event]
    if @event.save
      flash[:notice] = 'Event was successfully updated'
      redirect_to event_path(@event)
    else
      render :action => :edit
    end
  end
end
