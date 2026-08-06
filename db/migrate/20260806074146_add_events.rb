class AddEvents < ActiveRecord::Migration[7.2]
  def change
    add_column :events, :event_image, :string
  end
end
