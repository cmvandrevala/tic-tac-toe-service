class MoveRequest < ApplicationRecord

  def self.retrieve_all_data
    sql = "SELECT * FROM move_requests"
    pg_result = ActiveRecord::Base.connection.execute(sql)
    fields = pg_result.fields
    pg_result.values.map do |value_set|
      MoveRequest.instantiate(Hash[fields.zip(value_set)])
    end
  end

  def self.add_new_row(query_params = nil, ip_address = nil, returned_move = nil)
    sql = "INSERT INTO move_requests (created_at, updated_at, query_params, ip_address, returned_move) VALUES ('#{Time.now.getutc}', '#{Time.now.getutc}', '#{query_params}', '#{ip_address}', '#{returned_move}');"
    ActiveRecord::Base.connection.execute(sql)
  end

end
