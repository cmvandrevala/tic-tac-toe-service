class ComputerPlayersController < ApplicationController
  include ComputerPlayer

  def get_move
    if params[:board].blank?
      nil
    else
      hash = parse_json(params[:board])
      render json: {"move": move(hash)}
    end
  end

end
