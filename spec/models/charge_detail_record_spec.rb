require 'spec_helper'

describe ChargeDetailRecord do
  describe '#watt_hours_consumed' do
    it 'returns the difference between the meter_stop_value and meter_start_value' do
      cdr = ChargeDetailRecord.new(meter_start_value: 120000, meter_stop_value: 121000)
      expect(cdr.watt_hours_consumed).to eq(1000)
    end
  end

  describe '#time_duration_in_seconds' do
    it 'returns the time difference of meter_stop_time and meter_end_time in hours' do
      cdr = ChargeDetailRecord.new(meter_start_time: '2021-04-05T10:00:00Z', meter_stop_time: '2021-04-05T11:00:00Z')

      expect(cdr.time_duration_in_seconds).to eq(3600.0)
    end
  end
end
