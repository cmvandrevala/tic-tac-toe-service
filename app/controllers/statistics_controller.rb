class StatisticsController < ApplicationController

  def get_statistics
    statistics = MoveRequest.retrieve_all_data.to_json
    render json: "{\"statistics\": #{statistics}}"
  end

end
