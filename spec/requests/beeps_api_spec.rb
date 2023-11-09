require 'rails_helper'

RSpec.describe 'Beeps API' do
  let(:now) { Time.now.to_i }

  describe 'POST /beeps' do
    specify 'posting without any parameter returns a 400 status code' do
      post_beep({})
    end

    specify 'posting without a :pokemon_id parameter returns a 400 status code' do
      post_beep({ pokemon_id: nil, kind: :in, timestamp: now })
    end

    specify 'posting without a :kind parameter returns a 400 status code' do
      post_beep({ pokemon_id: 1, kind: nil, timestamp: now })
    end

    specify 'posting without a :timestamp parameter returns a 400 status code' do
      post_beep({ pokemon_id: 1, kind: :in, timestamp: nil })
    end

    specify 'posting with an invalid :pokemon_id parameter returns a 400 status code' do
      post_beep({ pokemon_id: 'bad', kind: :in, timestamp: now })
    end

    specify 'posting with an invalid :kind parameter returns a 400 status code' do
      post_beep({ pokemon_id: 1, kind: 'bad', timestamp: now })
    end

    specify 'posting with an invalid :timestamp parameter returns a 400 status code' do
      post_beep({ pokemon_id: 1, kind: :in, timestamp: 'bad' })
    end
  end
end
