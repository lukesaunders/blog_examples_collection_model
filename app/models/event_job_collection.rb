class EventJobCollection
  include ActiveModel::AttributeMethods
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  attr_accessor :event, :jobs

  def initialize(event, event_params = nil)
    @event = event
    unless event.jobs_finalized?
      if event_params
        @jobs = []
        if jobs = event_params["jobs"]
          jobs = jobs.values if jobs.is_a? Hash
          jobs.each do |job_values|
            @jobs << build_job(job_values)
          end
        end
      else
        @jobs = build_jobs
      end
    end
  end

  def valid?
    valid = event.valid?
    jobs.each do |job|
      valid = false unless job.valid?
    end
    valid
  end

  def save
    return false unless valid?
    jobs.each do |job|
      job.save
    end

    event.jobs_finalized = true
    event.save
  end

  def persisted?
    @event.jobs_finalized?
  end

  private

  def build_jobs
    [build_job(:name => "Erect a flag pole"), build_job(:name => "Raise the flag")]
  end

  def build_job(values)
    new_job = Job.new(values.symbolize_keys.merge(:event_id => @event.id, :done => false))
  end
end