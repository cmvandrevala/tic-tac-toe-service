class StatisticsController < ApplicationController

  def running_log
    log = MoveRequest.retrieve_all_data.to_json
    render json: "{\"log\": #{log}}"
  end

  def endpoints_hit
    render json: "{\"endpoints\": #{endpoints}}"
  end

  private

  def endpoints
    MoveRequest.endpoints_hit.map do |endpoint|
      {
        "client_name" => endpoint.client_name,
        "count" => endpoint.count
      }
    end.to_json
  end

end
