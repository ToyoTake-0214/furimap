class AddDetailsToEvents < ActiveRecord::Migration[8.1]
  def change
    add_column :events, :event_time, :string
    add_column :events, :store_count, :integer
    add_column :events, :event_url, :string
  end
end
