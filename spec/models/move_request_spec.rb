require "move_request"
require "pp"

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

  end

  describe "custom all" do

  end

end
