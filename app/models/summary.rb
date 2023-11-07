class Summary
  include ActiveModel::Validations
  attr_reader :pokemon_id, :from, :to
  
  validates_numericality_of :pokemon_id, only_integer: true, greater_than: 0
  validates_presence_of :pokemon_id, :from, :to
  
  def initialize(pokemon_id:, from:, to:)
    self.pokemon_id = pokemon_id
    self.from       = from
    self.to         = to
  end
  
  def pokemon_id=(value)
    @pokemon_id = value.to_i
  end
  
  def from=(value)
    @from = DateTime.parse(value) rescue nil
  end
  
  def to=(value)
    @to = DateTime.parse(value) rescue nil
  end
  
  def generate!
    validate! and generate
  end
  
  def generate
    problem_beeps, paired_beeps = beeps.slice_when { |a, b| a.does_not_pair_with(b) }
                                       .partition { |group| group.length < 2 }
                                       .map(&:flatten)
  
    {
      pokemon_id: @pokemon_id,
      from: @from.to_date,
      to: @to.to_date,
      presence_hours: presence_hours(paired_beeps),
      problematic_dates: problematic_dates(problem_beeps)
    }.to_json
  end
  
  private
  
  def beeps
    Beep.where(pokemon_id: pokemon_id)
        .between(from, to)
        .order(timestamp: :asc)
  end
  
  def presence_hours(beeps)
    beeps.in_groups_of(2)
          .map { |e_in, e_out| (e_out.timestamp - e_in.timestamp).to_f / 3600.0 }
          .sum
          .round(2)
  end
  
  def problematic_dates(beeps)
    beeps.map(&:date)
  end
end
