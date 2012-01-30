class AddExpectedTimeToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :expected_time, :string, :default => "0.00"
  end
end
