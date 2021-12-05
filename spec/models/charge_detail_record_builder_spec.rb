require 'spec_helper'

describe ChargeDetailRecordBuilder do
  describe '#call' do
    let(:charge_detail_rate_params) {
      {
        'meter_start_value' => 1204307,
        'meter_start_time' => "2021-04-05T10:04:00Z",
        'meter_stop_value' => 1215230,
        'meter_stop_time' => "2021-04-05T11:27:00Z",
      }
    }
    let(:charge_rate_params) {
      {
        'energy_rate' => 0.3,
        'time_rate' => 2,
        'transaction_rate' => 1
      }
    }

    context 'when a ChargeDetailRecord successfully saves' do
      it 'returns a saved charge_detail_record with a saved rate record' do
        charge_detail_rate = ChargeDetailRecordBuilder.call(charge_detail_rate_params,charge_rate_params )
        expect(charge_detail_rate.persisted?).to be(true)
        expect(charge_detail_rate.rate.persisted?).to be(true)
      end
    end

    context 'when a ChargeDetailRecord unsuccessfully saves' do
      it 'rolls back the transaction and does not save' do
        allow_any_instance_of(ChargeDetailRecord).to receive(:save).and_return(false)

        charge_detail_rate = ChargeDetailRecordBuilder.call(charge_detail_rate_params,charge_rate_params )
        expect(charge_detail_rate.persisted?).to be(false)
        expect(Rate.count).to be(0)
      end
    end
  end
end
