class StatisticsController < ApplicationController

  def running_log
    statistics = MoveRequest.retrieve_all_data.to_json
    render json: "{\"statistics\": #{statistics}}"
  end

end
