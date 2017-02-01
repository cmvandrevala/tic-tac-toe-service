class StatisticsController < ApplicationController

  def get_statistics
    statistics = MoveRequest.all.to_json
    render json: "{\"statistics\": #{statistics}}"
  end

end
