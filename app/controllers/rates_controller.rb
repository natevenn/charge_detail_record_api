class RatesController < ApplicationController
  def rate
    charge_detail_record = ChargeDetailRecordBuilder.call(charge_detail_record_params, charge_rate_params)
    if charge_detail_record.valid?
      render json: ChargeDetailRecordPresenter.new(charge_detail_record).present, status: :created
    else
      render json: present_errors, status: 400
    end
  end

  private

  def charge_rate_params
    {
      'energy_rate' => params.dig('rate', 'energy'),
      'time_rate' => params.dig('rate', 'time'),
      'transaction_rate' => params.dig('rate', 'transaction')
    }
  end

  def charge_detail_record_params
    {
      'meter_start_value' => params.dig('cdr', 'meterStart'),
      'meter_start_time' => params.dig('cdr', 'timestampStart'),
      'meter_stop_value' => params.dig('cdr', 'meterStop'),
      'meter_stop_time' => params.dig('cdr', 'timestampStop'),
    }
  end

  def present_errors
    rate_params = params.dig('rate').permit('energy', 'time', 'transaction').to_h
    cdr_params = params.dig('cdr').permit('meterStart', 'meterStop', 'timestampStart', 'timestampStop').to_h
    rate_params.merge(cdr_params).reduce({}) do |memo, (key, value)|
      if value.blank?
        memo[key] = "can't be blank"
      end
      memo
    end
  end
end