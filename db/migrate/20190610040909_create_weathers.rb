class CreateWeathers < ActiveRecord::Migration[5.2]
  def change
    create_table :weathers do |t|
      t.string :date_label, null: false
      t.string :telop_weather, null: false
      t.integer :weather_image_no, null: false
      t.integer :highest_temperature, null: false
      t.integer :lowest_temperature, null: false
      t.string :weather_url, null: false
      t.datetime :weather_announcement_datetime, null: false
      t.datetime :weather_update_datetime, null: false

      t.timestamps
    end
  end
end
