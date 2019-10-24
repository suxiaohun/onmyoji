class ShiShen < ApplicationRecord

  has_many :pieces, foreign_key: :sid


  def path
    if self.mode == 'SSR'
      "yys/before/ssr/#{self.sid}.jpg"
    elsif self.mode == 'SP'
      "yys/before/sp/#{self.sid}.jpg"
    end
  end

end
