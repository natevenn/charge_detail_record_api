class ChargeDetailRecordBuilder
  def self.call(charge_detail_rate_params, rate_params)
    charge_detail_record = ChargeDetailRecord.new(charge_detail_rate_params)
    charge_detail_record.transaction do
      rate = Rate.create(rate_params)
      charge_detail_record.rate_id = rate.id
      success = charge_detail_record.save

      raise ActiveRecord::Rollback unless success
    end

    return charge_detail_record
  end
end