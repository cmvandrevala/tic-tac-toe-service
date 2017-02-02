require "statistics_controller"

describe StatisticsController do

  describe "returning JSON data of the endpoints hit" do

    it "returns an empty object if there is no data in the database" do
      get :running_log
      expect(response.body).to eq "{\"log\": []}"
    end

    it "returns a single item in the database" do
      MoveRequest.add_new_row("foo", "bar", "baz", "quo")
      get :running_log
      expect(response.body).to include ",\"query_params\":\"foo\",\"ip_address\":\"bar\",\"returned_move\":\"baz\",\"client_name\":\"quo\"}]}"
    end

    it "returns two items" do
      MoveRequest.add_new_row("foo1", "bar1", "baz1", "quo1")
      MoveRequest.add_new_row("foo2", "bar2", "baz2", "quo2")
      get :running_log
      expect(response.body).to include ",\"query_params\":\"foo1\",\"ip_address\":\"bar1\",\"returned_move\":\"baz1\",\"client_name\":\"quo1\"}"
      expect(response.body).to include ",\"query_params\":\"foo2\",\"ip_address\":\"bar2\",\"returned_move\":\"baz2\",\"client_name\":\"quo2\"}"
    end

    it "returns many items" do
      MoveRequest.add_new_row("foo1", "bar1", "baz1", "quo1")
      MoveRequest.add_new_row("foo2", "bar2", "baz2", "quo2")
      MoveRequest.add_new_row("foo3", "bar3", "baz3", "quo3")
      get :running_log
      expect(response.body).to include ",\"query_params\":\"foo1\",\"ip_address\":\"bar1\",\"returned_move\":\"baz1\",\"client_name\":\"quo1\"}"
      expect(response.body).to include ",\"query_params\":\"foo2\",\"ip_address\":\"bar2\",\"returned_move\":\"baz2\",\"client_name\":\"quo2\"}"
      expect(response.body).to include ",\"query_params\":\"foo3\",\"ip_address\":\"bar3\",\"returned_move\":\"baz3\",\"client_name\":\"quo3\"}"
    end

  end

end
