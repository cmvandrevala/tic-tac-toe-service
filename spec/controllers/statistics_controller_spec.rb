require "statistics_controller"

describe StatisticsController do

  describe "returning JSON data of the endpoints hit" do

    it "returns an empty object if there is no data in the database" do
      get :get_statistics
      expect(response.body).to eq "{\"statistics\": []}"
    end

    it "returns a single item in the database with no data" do
      sql = "INSERT INTO move_requests (created_at, updated_at, query_params, ip_address, returned_move) VALUES ('#{Time.now.getutc}', '#{Time.now.getutc}', null, null, null);"
      ActiveRecord::Base.connection.execute(sql)
      get :get_statistics
      expect(response.body).to include ",\"query_params\":null,\"ip_address\":null,\"returned_move\":null}]}"
    end

    it "returns a single item in the database" do
      sql = "INSERT INTO move_requests (created_at, updated_at, query_params, ip_address, returned_move) VALUES ('#{Time.now.getutc}', '#{Time.now.getutc}', 'foo', 'bar', 'baz');"
      ActiveRecord::Base.connection.execute(sql)
      get :get_statistics
      expect(response.body).to include ",\"query_params\":\"foo\",\"ip_address\":\"bar\",\"returned_move\":\"baz\"}]}"
    end

    it "returns two items" do
      sql = "INSERT INTO move_requests (created_at, updated_at, query_params, ip_address, returned_move) VALUES ('#{Time.now.getutc}', '#{Time.now.getutc}', 'foo1', 'bar1', 'baz1');"
      ActiveRecord::Base.connection.execute(sql)
      sql = "INSERT INTO move_requests (created_at, updated_at, query_params, ip_address, returned_move) VALUES ('#{Time.now.getutc}', '#{Time.now.getutc}', 'foo2', 'bar2', 'baz2');"
      ActiveRecord::Base.connection.execute(sql)
      get :get_statistics
      expect(response.body).to include ",\"query_params\":\"foo1\",\"ip_address\":\"bar1\",\"returned_move\":\"baz1\"}"
      expect(response.body).to include ",\"query_params\":\"foo2\",\"ip_address\":\"bar2\",\"returned_move\":\"baz2\"}"
    end

    it "returns many items" do
      sql = "INSERT INTO move_requests (created_at, updated_at, query_params, ip_address, returned_move) VALUES ('#{Time.now.getutc}', '#{Time.now.getutc}', 'foo1', 'bar1', 'baz1');"
      ActiveRecord::Base.connection.execute(sql)
      sql = "INSERT INTO move_requests (created_at, updated_at, query_params, ip_address, returned_move) VALUES ('#{Time.now.getutc}', '#{Time.now.getutc}', 'foo2', 'bar2', 'baz2');"
      ActiveRecord::Base.connection.execute(sql)
      sql = "INSERT INTO move_requests (created_at, updated_at, query_params, ip_address, returned_move) VALUES ('#{Time.now.getutc}', '#{Time.now.getutc}', 'foo3', 'bar3', 'baz3');"
      ActiveRecord::Base.connection.execute(sql)
      get :get_statistics
      expect(response.body).to include ",\"query_params\":\"foo1\",\"ip_address\":\"bar1\",\"returned_move\":\"baz1\"}"
      expect(response.body).to include ",\"query_params\":\"foo2\",\"ip_address\":\"bar2\",\"returned_move\":\"baz2\"}"
      expect(response.body).to include ",\"query_params\":\"foo3\",\"ip_address\":\"bar3\",\"returned_move\":\"baz3\"}"
    end

  end

end
