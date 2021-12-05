class Rate < ApplicationRecord
  validates_presence_of :energy_rate, :time_rate, :transaction_rate
end