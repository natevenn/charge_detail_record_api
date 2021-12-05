class CreateRate < ActiveRecord::Migration[6.1]
  def change
    create_table :rates do |t|
      t.decimal :energy_rate
      t.decimal :time_rate
      t.decimal :transaction_rate
      t.timestamps
    end
  end
end
