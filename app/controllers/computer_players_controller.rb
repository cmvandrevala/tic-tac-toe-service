class ComputerPlayersController < ApplicationController
  include ComputerPlayer
  after_action :add_record_to_database

  def get_move
    render json: {"move": computed_move} unless no_query_params?
  end

  private

  def add_record_to_database
    MoveRequest.new(query_params: params[:board],
                    ip_address: request.remote_ip,
                    returned_move: computed_move).save unless no_query_params?
  end

  def no_query_params?
    params[:board].blank?
  end

  def computed_move
    hash = parse_json(params[:board])
    move(hash)
  end

end
