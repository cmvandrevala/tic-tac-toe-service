class StatisticsController < ApplicationController

  def get_statistics
    sql = "SELECT * FROM move_requests;"
    records_array = ActiveRecord::Base.connection.execute(sql)
    statistics = records_array.to_json
    render json: "{\"statistics\": #{statistics}}"
  end

end
