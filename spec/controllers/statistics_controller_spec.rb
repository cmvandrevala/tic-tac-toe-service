require "statistics_controller"

describe StatisticsController do

  describe "returning JSON data of the endpoints hit" do

    it "returns an empty object if there is no data in the database" do
      get :get_statistics
      expect(response.body).to eq "{\"statistics\": []}"
    end

    it "returns a single item in the database with no data" do
      MoveRequest.new.save
      get :get_statistics
      expect(response.body).to include ",\"query_params\":null,\"ip_address\":null,\"returned_move\":null}]}"
    end

    it "returns a single item in the database" do
      MoveRequest.new(query_params: "foo", ip_address: "bar", returned_move: "baz").save
      get :get_statistics
      expect(response.body).to include ",\"query_params\":\"foo\",\"ip_address\":\"bar\",\"returned_move\":\"baz\"}]}"
    end

    it "returns two items" do
      MoveRequest.new(query_params: "foo1", ip_address: "bar1", returned_move: "baz1").save
      MoveRequest.new(query_params: "foo2", ip_address: "bar2", returned_move: "baz2").save
      get :get_statistics
      expect(response.body).to include ",\"query_params\":\"foo1\",\"ip_address\":\"bar1\",\"returned_move\":\"baz1\"}"
      expect(response.body).to include ",\"query_params\":\"foo2\",\"ip_address\":\"bar2\",\"returned_move\":\"baz2\"}"
    end

  end

end
