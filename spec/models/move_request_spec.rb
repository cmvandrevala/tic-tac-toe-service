require "move_request"

describe MoveRequest do

  describe "table columns" do

    it "includes a string of query params" do
      sql = "SELECT column_name FROM information_schema.columns WHERE table_name='move_requests' and column_name='query_params'"
      pg_result = ActiveRecord::Base.connection.execute(sql)
      expect(pg_result.cmd_status).to eq "SELECT 1"
    end

    it "includes an IP address" do
      sql = "SELECT column_name FROM information_schema.columns WHERE table_name='move_requests' and column_name='ip_address'"
      pg_result = ActiveRecord::Base.connection.execute(sql)
      expect(pg_result.cmd_status).to eq "SELECT 1"
    end

    it "includes the returned move" do
      sql = "SELECT column_name FROM information_schema.columns WHERE table_name='move_requests' and column_name='returned_move'"
      pg_result = ActiveRecord::Base.connection.execute(sql)
      expect(pg_result.cmd_status).to eq "SELECT 1"
    end

    it "includes a client name" do
      sql = "SELECT column_name FROM information_schema.columns WHERE table_name='move_requests' and column_name='client_name'"
      pg_result = ActiveRecord::Base.connection.execute(sql)
      expect(pg_result.cmd_status).to eq "SELECT 1"
    end

  end

  describe "#retrive_all_data and #add_new_row" do

    it "returns no values database is empty" do
      expect(MoveRequest.retrieve_all_data).to eq []
    end

    it "it adds a new row with data to the database" do
      MoveRequest.add_new_row("foo", "bar", "baz", "quo")
      expect(MoveRequest.exists?(query_params: 'foo')).to be_truthy
      expect(MoveRequest.exists?(ip_address: "bar")).to be_truthy
      expect(MoveRequest.exists?(returned_move: "baz")).to be_truthy
      expect(MoveRequest.exists?(client_name: "quo")).to be_truthy
    end

    it "it returns two values if the database has two rows" do
      MoveRequest.add_new_row("foo", "bar", "baz", "quo")
      MoveRequest.add_new_row("xyz", "abc", "123", "qwe")
      expect(MoveRequest.retrieve_all_data.length).to eq 2
    end

    it "the returned resuls are identical to ActiveRecord's #all method" do
      MoveRequest.add_new_row("foo", "bar", "baz", "foo")
      MoveRequest.add_new_row("quo", "abc", "123", "qwerty")
      expect(MoveRequest.retrieve_all_data).to eq MoveRequest.all
    end

  end

end
