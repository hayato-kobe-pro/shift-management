class CreateSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :schedules do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.integer :user_id
      t.integer :room_id
      t.integer :clone_id
      t.timestamps
    end
  end
end
