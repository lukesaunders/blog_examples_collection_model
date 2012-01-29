class Job < ActiveRecord::Base
  belongs_to :event

  def self.template_jobs
    [new(:name => "Erect a flag pole", :done => false), new(:name => "Raise the flag", :done => false)]
  end
end
