class JobsController < ApplicationController
  def index
    @jobs = Job.all
  end

  def show
    @job = Job.find(params[:id])
  end

  def new
    @job = Job.new
  end

  def edit
    @job = Job.find(params[:id])
  end

  def create
    @job = Job.new(params[:job])

    if @job.save
      flash[:notice] = 'Job was successfully created'
      redirect_to @job, notice: 'Job was successfully created.'
    else
      render :action => :new
    end
  end

  def update
    @job = Job.find(params[:id])

    @job.attributes = params[:job]
    if @job.save
      flash[:notice] = 'Job was successfully updated'
      redirect_to job_path(@job)
    else
      render :action => :edit
    end
  end
end
