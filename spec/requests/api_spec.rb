require 'rails_helper'

RSpec.describe 'public api' do
  describe 'GET /summaries/{pokemon_id}/{from}/{to}' do
    let(:first_pokemon) { 1 }
    let(:second_pokemon) { 2 }

    it 'generates summary based on beeps' do
      given_beep(pokemon_id: first_pokemon, timestamp: '2019-05-01 08:00', kind: :in)
      given_beep(pokemon_id: first_pokemon, timestamp: '2019-05-01 16:00', kind: :out)
      given_beep(pokemon_id: first_pokemon, timestamp: '2019-05-02 08:00', kind: :in)
      given_beep(pokemon_id: first_pokemon, timestamp: '2019-05-02 16:00', kind: :out)
  
      summary = summary(pokemon_id: first_pokemon, from: '2019-05-01', to: '2019-05-30')
  
      expect(summary).to include({
                                  pokemon_id: first_pokemon,
                                  from: '2019-05-01', to: '2019-05-30',
                                  presence_hours: 16.0,
                                  problematic_dates: []
                                })
    end
  
    it 'rounds presence hours to two decimal places' do
      given_beep(pokemon_id: first_pokemon, timestamp: '2019-05-01 08:10:00:050', kind: :in)
      given_beep(pokemon_id: first_pokemon, timestamp: '2019-05-01 16:00:01:070', kind: :out)
  
      summary = summary(pokemon_id: first_pokemon, from: '2019-05-01', to: '2019-05-01')
  
      expect(summary[:presence_hours]).to eq(7.83)
    end
  
    it 'discovers problematic date when there is no leave beep' do
      given_beep(pokemon_id: first_pokemon, timestamp: '2019-05-01 08:00', kind: :in)
      given_beep(pokemon_id: first_pokemon, timestamp: '2019-05-02 08:00', kind: :in)
      given_beep(pokemon_id: first_pokemon, timestamp: '2019-05-02 16:00', kind: :out)
  
      summary = summary(pokemon_id: first_pokemon, from: '2019-05-01', to: '2019-05-30')
  
      expect(summary).to include({
                                  pokemon_id: first_pokemon,
                                  from: '2019-05-01', to: '2019-05-30',
                                  presence_hours: 8.0,
                                  problematic_dates: ['2019-05-01']
                                })
    end
  
    it 'discovers problematic date when there is skip day beep' do
      given_beep(pokemon_id: first_pokemon, timestamp: '2019-05-01 08:00', kind: :in)
      given_beep(pokemon_id: first_pokemon, timestamp: '2019-05-02 16:00', kind: :out)
  
      summary = summary(pokemon_id: first_pokemon, from: '2019-05-01', to: '2019-05-30')
  
      expect(summary).to include({
                                  pokemon_id: first_pokemon,
                                  from: '2019-05-01', to: '2019-05-30',
                                  presence_hours: 0.0,
                                  problematic_dates: ['2019-05-01', '2019-05-02']
                                })
    end
  end
end
