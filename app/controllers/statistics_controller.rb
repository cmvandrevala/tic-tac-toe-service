class StatisticsController < ApplicationController
  before_action :add_record_to_database

  ROUTES_TO_DISPLAY = ['/api/computer_move', '/api/endpoints_hit']

  def running_log
    render json: "{\"log\": #{MoveRequest.retrieve_all_data.to_json}}"
  end

  def endpoints_hit
    render json: {"endpoints_hit" => hit_count}.to_json
  end

  private

  def hit_count
    ROUTES_TO_DISPLAY.map { |route| {route => endpoints(route)} }
  end

  def endpoints(route)
    MoveRequest.endpoints_hit(route).map do |endpoint|
      {
        "client_name" => endpoint.client_name,
        "count" => endpoint.count
      }
    end
  end

  def add_record_to_database
    MoveRequest.add_new_row("", request.remote_ip, "", params[:client_name], request.path)
  end

end
