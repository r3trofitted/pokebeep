class BeepsController < ApplicationController
  def save
    beep = Beep.new beep_params
    
    begin
      beep.save!
      render json: beep
    rescue ActiveRecord::RecordInvalid => invalid
      render nothing: true, status: :bad_request
    end
  end
  
  protected
  
  def beep_params
    params.permit(:pokemon_id, :kind, :timestamp)
  end
end
