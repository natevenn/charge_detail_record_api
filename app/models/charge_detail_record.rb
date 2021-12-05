class ChargeDetailRecord < ApplicationRecord
  belongs_to :rate, class_name: 'Rate'

  validates_presence_of :meter_start_value, :meter_start_time,
    :meter_stop_value, :meter_stop_time, :rate_id

  def watt_hours_consumed
    meter_stop_value - meter_start_value
  end

  def time_duration_in_seconds
    meter_stop_time - meter_start_time
  end
end
