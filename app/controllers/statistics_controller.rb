class StatisticsController < ApplicationController

  def running_log
    log = MoveRequest.retrieve_all_data.to_json
    render json: "{\"log\": #{log}}"
  end

  def endpoints_hit
    routes = ['/api/computer_move', '/api/endpoints_hit', '/api/running_log']
    output = routes.map { |route| {route => endpoints(route)} }
    render json: {"endpoints_hit" => output}.to_json
  end

  private

  def endpoints(route)
    MoveRequest.endpoints_hit(route).map do |endpoint|
      {
        "client_name" => endpoint.client_name,
        "count" => endpoint.count
      }
    end
  end

end
