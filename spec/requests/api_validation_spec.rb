require 'rails_helper'

RSpec.describe 'api validation' do
  let(:now) { Time.now.to_i }

  describe 'POST /beeps' do
    context 'when posting beep with wrong request params' do
      it 'returns 400 status code' do
        post_beep({})
      end
  
      it 'returns 400 status code' do
        post_beep({ pokemon_id: nil, kind: :in, timestamp: now })
      end
  
      it 'returns 400 status code' do
        post_beep({ pokemon_id: 1, kind: nil, timestamp: now })
      end
  
      it 'returns 400 status code' do
        post_beep({ pokemon_id: 1, kind: :in, timestamp: nil })
      end
  
      it 'returns 400 status code' do
        post_beep({ pokemon_id: 'bad', kind: :in, timestamp: now })
      end
  
      it 'returns 400 status code' do
        post_beep({ pokemon_id: 1, kind: 'bad', timestamp: now })
      end
  
      it 'returns 400 status code' do
        post_beep({ pokemon_id: 1, kind: :in, timestamp: 'bad' })
      end
    end
  end

  describe 'GET /summaries/{pokemon_id}/{from}/{to}' do
    context 'when getting summary with wrong request params' do
      it 'returns 400 status code' do
        get_summary(1, 'bad', '2019-01-01')
  
        expect(response.status).to eq(400)
      end
  
      it 'returns 400 status code' do
        get_summary(1, '2019-01-01', 'bad')
  
        expect(response.status).to eq(400)
      end
  
      it 'returns 400 status code' do
        get_summary('bad', '2019-01-01', '2019-02-02')
  
        expect(response.status).to eq(400)
      end
    end
  end
end
