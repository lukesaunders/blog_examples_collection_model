class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :name
      t.integer :event_id
      t.boolean :done

      t.timestamps
    end
  end
end
