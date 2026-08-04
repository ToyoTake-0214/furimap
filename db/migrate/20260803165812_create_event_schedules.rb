class CreateEventSchedules < ActiveRecord::Migration[7.2]
  def change
    create_table :event_schedules do |t|
      t.references :event, null: false, foreign_key: true
      t.date :event_date, null: false
      t.timestamps
    end
  end
end
