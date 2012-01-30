class AddJobsFinalizedToEvents < ActiveRecord::Migration
  def change
    add_column :events, :jobs_finalized, :boolean, :default => false
  end
end
