require "computer_player"

class ComputerPlayersController < ApplicationController
  include ComputerPlayer
  before_action :add_record_to_database

  def computer_move
    render json: {"move": computed_move} if query_params?
  end

  private

  def add_record_to_database
    if query_params?
      MoveRequest.add_new_row(params[:board], request.remote_ip, computed_move, params[:client_name], request.path)
    end
  end

  def query_params?
    !params[:board].blank?
  end

  def computed_move
    hash = parse_json(params[:board])
    move(hash)
  end

end
