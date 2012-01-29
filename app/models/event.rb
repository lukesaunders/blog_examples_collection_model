class Event < ActiveRecord::Base
  has_many :jobs

  accepts_nested_attributes_for :jobs
end
