class IpNickName < ApplicationRecord

  before_save :update_seq


  after_save :clear_old_bindings


  private

  def update_seq
    self.seq = (IpNickName.maximum(:seq) || 0) + 1
  end

  def clear_old_bindings
    puts "============start clear old data============="
    records = IpNickName.where(ip: self.ip).where("seq < #{self.seq}")
    records.each do |record|
      Bloodline.where(name: record.name).delete_all
      record.delete
    end
  end
end
