class Piece < ApplicationRecord
  attr_accessor :need_shi_shen_names, :match_rate
  belongs_to :shi_shen, primary_key: :sid, foreign_key: :sid

  validates_uniqueness_of :sid, scope: [:sama, :mode]

end
