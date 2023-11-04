module PublicApi
  def given_beep(pokemon_id: 1, timestamp: Time.zone.now, kind: :in)
    t = to_unix(timestamp)
    post_beep(pokemon_id: pokemon_id, timestamp: t, kind: kind)
    expect(response.status).to eq(200)
  end

  def post_beep(params = {})
    post('/beeps', params: params)
  end

  def summary(pokemon_id:, from:, to:)
    get_summary(pokemon_id, from, to)
    expect(response.status).to eq(200)
    JSON.parse(response.body).symbolize_keys
  end

  def get_summary(pokemon_id, from, to)
    get("/summaries/#{pokemon_id}/#{from}/#{to}")
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
