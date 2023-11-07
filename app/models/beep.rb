class Beep < ApplicationRecord
  enum :kind, %w[in out], validate: true
  
  validates_presence_of :pokemon_id, :kind, :timestamp
  validates_numericality_of :pokemon_id
  
  scope :between, ->(from, to) { where(timestamp: from.beginning_of_day..to.end_of_day) }
  
  def timestamp=(val)
    if val.to_s.match? /\d+/ # To ensure that invalid values result in a nil attribute
      super Time.at(val.to_i).to_datetime
    end
  end
  
  def does_not_pair_with(other)
    kind == other.kind || date != other.date
  end
  
  def date
    timestamp.to_date
  end
end
