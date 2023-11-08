require 'rails_helper'

RSpec.describe 'Beeps API' do
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
end
