require 'spec_helper'

describe ChargeDetailRecordCalculator do
  let!(:described_instance) do
    ChargeDetailRecordCalculator.new(
      watt_hours: 10923,
      energy_rate: 0.3.to_d,
      time_duration_in_seconds: 4980.0.to_d,
      time_rate: 2.to_d,
      transaction_rate: 1.to_d
    )
  end

  describe '#overall_charge' do
    it 'sums the energy_charge, time_charge and transaction_charge rounded to 2 decimals' do
      expect(described_instance.overall_charge).to eq(7.04)
    end

    it 'returns nil if it can not calculate any of the values' do
      calculator = described_class.new(
        watt_hours: nil,
        energy_rate: BigDecimal('0.3'),
        time_duration_in_seconds: BigDecimal('4980.0'),
        time_rate: BigDecimal('2'),
        transaction_rate: BigDecimal('1')
      )

      expect(calculator.overall_charge).to eq(nil)
    end
  end

  describe '#energy_charge' do
    it 'returns the kilowatt hours * energy_rate rounded to 3 decimal places' do
      expect(described_instance.energy_charge).to eq(3.277)
    end

    it 'returns nil if it can not calculate any of the values' do
      calculator = described_class.new(
        watt_hours: 1000,
        energy_rate: nil,
        time_duration_in_seconds: BigDecimal('4980.0'),
        time_rate: BigDecimal('2'),
        transaction_rate: BigDecimal('1')
      )

      expect(calculator.energy_charge).to eq(nil)
    end
  end

  describe '#time_charge' do
    it 'returns the kilowatt hours * energy_rate rounded to 3 decimal places' do
      expect(described_instance.time_charge).to eq(2.767)
    end

    it 'returns nil if it can not calculate any of the values' do
      calculator = described_class.new(
        watt_hours: 1000,
        energy_rate: nil,
        time_duration_in_seconds: BigDecimal('4980.0'),
        time_rate: BigDecimal('2'),
        transaction_rate: BigDecimal('1')
      )

      expect(calculator.time_charge).to eq(nil)
    end
  end
end
