require 'spec_helper'

describe ChargeDetailRecordPresenter do
  let(:rate) do
    Rate.create(
      energy_rate: 0.1,
      time_rate: 1,
      transaction_rate: 1
    )
  end

  let(:charge_detail_record) do
    ChargeDetailRecord.create(
      meter_start_value: 120000,
      meter_stop_value: 121000,
      meter_start_time: '2021-04-05T10:04:00Z',
      meter_stop_time: '2021-04-05T11:27:00Z',
      rate_id: rate.id
    )
  end

  describe '#present' do
    context 'when charge_detail_record is present' do
      before do
        calculator_double = double('calculator_double')
        expect(ChargeDetailRecordCalculator).to receive(:new).with(
          watt_hours: charge_detail_record.watt_hours_consumed,
          energy_rate: rate.energy_rate,
          time_duration_in_seconds: charge_detail_record.time_duration_in_seconds,
          time_rate: rate.time_rate,
          transaction_rate: rate.transaction_rate
        ).once.and_return(calculator_double)
        allow(calculator_double).to receive(:overall_charge).and_return(7.04)
        allow(calculator_double).to receive(:energy_charge).and_return(3.277)
        allow(calculator_double).to receive(:time_charge).and_return(2.767)
        allow(calculator_double).to receive(:transaction_charge).and_return(1)
      end

      it 'returns an object with the overall charge and components of the charge' do
        result = ChargeDetailRecordPresenter.new(charge_detail_record).present

        expect(result).to eq(
          {
            "overall" => 7.04,
            "components" => {
              "energy" => 3.277,
              "time" => 2.767,
              "transaction" => 1
            }
          }
        )
      end
    end

    context 'when charge_detail_record is blank' do
      it 'returns an empty object' do
        expect(ChargeDetailRecordCalculator).not_to receive(:new)

        result = ChargeDetailRecordPresenter.new({}).present

        expect(result).to eq({})
      end
    end
  end
end
