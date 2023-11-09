module ApiHelpers
  def given_beep(pokemon_id: 1, timestamp: Time.zone.now, kind: :in)
    t = to_unix(timestamp)
    post('/beeps', params: { pokemon_id:, timestamp: t, kind: })
    expect(response.status).to eq(200)
  end

  def summary(pokemon_id:, from:, to:)
    get("/summaries/#{pokemon_id}/#{from}/#{to}")
    expect(response.status).to eq(200)
    JSON.parse(response.body).symbolize_keys
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
