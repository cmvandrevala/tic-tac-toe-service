require 'date'

class ComputerPlayersController < ApplicationController
  include ComputerPlayer
  after_action :add_record_to_database

  def get_move
    render json: {"move": computed_move} unless no_query_params?
  end

  private

  def add_record_to_database
    unless no_query_params?
      MoveRequest.add_new_row(params[:board], request.remote_ip, computed_move)
    end
  end

  def no_query_params?
    params[:board].blank?
  end

  def computed_move
    hash = parse_json(params[:board])
    move(hash)
  end

end
