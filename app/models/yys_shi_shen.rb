class YysShiShen < ApplicationRecord

  has_many :pieces, foreign_key: :sid
  attr_accessor :color, :owned

  def show_color
    if self.kind == 'kind'
      'rgb(232,112,30)'
    else
      'rgb(232,112,30)'
    end
  end
end
