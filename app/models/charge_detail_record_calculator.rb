class ChargeDetailRecordCalculator
  def initialize(watt_hours:, energy_rate:, time_duration_in_seconds:, time_rate:, transaction_rate:)
    @watt_hours = watt_hours
    @energy_rate = energy_rate
    @time_duration_in_seconds = time_duration_in_seconds
    @time_rate = time_rate
    @transaction_rate = transaction_rate
  end

  def overall_charge
    return if any_invalid_values?
    (energy_charge + time_charge + transaction_charge).round(2)
  end

  def energy_charge
    return if any_invalid_values?
    ((watt_hours * energy_rate) / 1000).round(3).to_f
  end

  def time_charge
    return if any_invalid_values?
    (time_duration_in_hours * time_rate).round(3).to_f
  end

  def transaction_charge
    return if any_invalid_values?
    transaction_rate.to_i
  end

  private
  attr_reader :watt_hours, :energy_rate, :time_duration_in_seconds,
    :time_rate, :transaction_rate

  def any_invalid_values?
    [
      watt_hours,
      energy_rate,
      time_duration_in_seconds,
      time_rate,
      transaction_rate
    ].any? { |parameter| parameter.nil? }
  end

  def time_duration_in_hours
    ((time_duration_in_seconds) / 60) / 60
  end
end