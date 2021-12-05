class CreateChargeDetailRecord < ActiveRecord::Migration[6.1]
  def change
    create_table :charge_detail_records do |t|
      t.integer :meter_start_value
      t.datetime :meter_start_time
      t.integer :meter_stop_value
      t.datetime :meter_stop_time
      t.integer :rate_id
      t.timestamps
    end
  end
end
