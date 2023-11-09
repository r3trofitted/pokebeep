require 'rails_helper'

RSpec.describe 'Beeps API' do
  let(:now) { Time.now.to_i }

  describe 'POST /beeps' do
    specify 'posting without any parameter returns a 400 status code' do
      post_beep({})
      expect(response).to have_http_status(:bad_request)
    end

    specify 'posting without a :pokemon_id parameter returns a 400 status code' do
      post_beep({ pokemon_id: nil, kind: :in, timestamp: now })
      expect(response).to have_http_status(:bad_request)
    end

    specify 'posting without a :kind parameter returns a 400 status code' do
      post_beep({ pokemon_id: 1, kind: nil, timestamp: now })
      expect(response).to have_http_status(:bad_request)
    end

    specify 'posting without a :timestamp parameter returns a 400 status code' do
      post_beep({ pokemon_id: 1, kind: :in, timestamp: nil })
      expect(response).to have_http_status(:bad_request)
    end

    specify 'posting with an invalid :pokemon_id parameter returns a 400 status code' do
      post_beep({ pokemon_id: 'bad', kind: :in, timestamp: now })
      expect(response).to have_http_status(:bad_request)
    end

    specify 'posting with an invalid :kind parameter returns a 400 status code' do
      post_beep({ pokemon_id: 1, kind: 'bad', timestamp: now })
      expect(response).to have_http_status(:bad_request)
    end

    specify 'posting with an invalid :timestamp parameter returns a 400 status code' do
      post_beep({ pokemon_id: 1, kind: :in, timestamp: 'bad' })
      expect(response).to have_http_status(:bad_request)
    end
  end
end
