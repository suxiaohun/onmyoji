class YysShiShen < ApplicationRecord

  has_many :pieces, foreign_key: :sid
  attr_accessor :color, :owned

end
