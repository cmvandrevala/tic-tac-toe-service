require "move_request"

describe MoveRequest do

  describe "table columns" do

    it "includes a string of query params" do
      expect(MoveRequest.new).to respond_to(:query_params)
    end

    it "includes an IP address" do
      expect(MoveRequest.new).to respond_to(:ip_address)
    end

    it "includes the returned move" do
      expect(MoveRequest.new).to respond_to(:returned_move)
    end

  end

end
