class SummariesController < ApplicationController
  def get
    params.permit!.to_h.symbolize_keys => { pokemon_id:, from:, to: }
    
    summary = Summary.new(pokemon_id:, from:, to:)
    
    render json: summary.generate!
  end
end
