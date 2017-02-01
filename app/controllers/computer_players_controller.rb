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
      sql = "INSERT INTO move_requests (created_at, updated_at, query_params, ip_address, returned_move) VALUES ('#{Time.now.getutc}', '#{Time.now.getutc}', '#{params[:board]}', '#{request.remote_ip}', #{computed_move});"
      ActiveRecord::Base.connection.execute(sql)
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
