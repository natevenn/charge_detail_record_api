require 'spec_helper'

describe RatesController, type: :controller do
  describe '/rate' do
    let(:params) do
      {
        "rate" => {
          "energy" => 0.3,
          "time" => 2,
          "transaction" => 1
        },
        "cdr" => {
          "meterStart" => 1204307,
          "timestampStart" => "2021-04-05T10:04:00Z",
          "meterStop" => 1215230,
          "timestampStop" => "2021-04-05T11:27:00Z"
        }
      }
    end

    context 'when successful' do
      it 'returns the JSON for rate with ' do
        post :rate, params: params

        response_body = JSON.parse(response.body)

        expect(response.status).to eq(201)
        expect(response_body).to eq(
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

    context 'when unsuccessful' do
      it 'returns a 400' do
        new_charge_detail_record = ChargeDetailRecord.new
        allow(ChargeDetailRecordBuilder).to receive(:call).and_return(new_charge_detail_record)

        post :rate, params: params

        expect(response.status).to eq(400)
      end
    end
  end
end
