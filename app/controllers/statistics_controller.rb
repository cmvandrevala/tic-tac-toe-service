class StatisticsController < ApplicationController

  def get_statistics
    sql = "SELECT * FROM move_requests;"
    records_array = MoveRequest.retrieve_all_data
    statistics = records_array.to_json
    render json: "{\"statistics\": #{statistics}}"
  end

end
