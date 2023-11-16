module ApiHelpers
  def given_beep(pokemon_id: 1, timestamp: Time.zone.now, kind: :in)
    Beep.create! pokemon_id:, kind:, timestamp: to_unix(timestamp)
  end

  private

  def to_unix(timestamp)
    case timestamp
    when String
      Time.parse(timestamp).to_i
    when Time
      timestamp.to_i
    when Number
      timestamp.to_i
    else
      raise ArgumentError, 'Invalid timestamp type. Only String, Time and Number are supported.'
    end
  end
end
