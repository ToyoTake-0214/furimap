class CreateEventSchedules < ActiveRecord::Migration[7.2]
  def change
    create_table :event_schedules do |t|
      t.timestamps
    end
  end
end
