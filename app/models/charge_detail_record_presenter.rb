class ChargeDetailRecordPresenter
  def initialize(charge_detail_record)
    @charge_detail_record = charge_detail_record
  end

  def present
    return {} if charge_detail_record.blank?
    {
      "overall" => calculator.overall_charge,
      "components" => {
        "energy" => calculator.energy_charge,
        "time" => calculator.time_charge,
        "transaction" => calculator.transaction_charge
      }
    }
  end

  private

  attr_reader :charge_detail_record

  def calculator
    @charge_detail_record_calculator ||= ChargeDetailRecordCalculator.new(
      watt_hours: charge_detail_record.watt_hours_consumed,
      energy_rate: rate.energy_rate,
      time_duration_in_seconds: charge_detail_record.time_duration_in_seconds,
      time_rate: rate.time_rate,
      transaction_rate: rate.transaction_rate
    )
  end

  def rate
    @rate ||= charge_detail_record.rate
  end
end