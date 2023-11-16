module ApiHelpers
  def given_beep(pokemon_id: 1, timestamp: Time.zone.now, kind: :in)
    Beep.create! pokemon_id:, kind:, timestamp: Time.parse(timestamp).to_i
  end
end
