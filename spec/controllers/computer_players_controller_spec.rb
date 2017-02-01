require 'computer_players_controller'

describe ComputerPlayersController do

  describe 'getting a move' do

    context 'first available spot computer player' do

      it 'returns a status code of 204 if no params are given' do
        get :get_move
        expect(response).to have_http_status 204
      end

      it 'returns a status code of 200 if a current board is given' do
        get :get_move, params: {board: '{"moves": [{"player_one":"1"}, {"player_two":"5"}]}'}
        expect(response).to have_http_status 200
      end

      it 'returns a status code of 204 if a current board is not given' do
        get :get_move, params: {random1: "param1", random2: "param2"}
        expect(response).to have_http_status 204
      end

      it 'returns cell zero if the board is empty' do
        user_params = {board: '{"moves": []}'}
        get :get_move, params: user_params
        expect(response.body).to eq "{\"move\":0}"
      end

      it 'returns cell zero if the first spot is available' do
        user_params = {board: '{"moves":[{"player_one":"5"}]}'}
        get :get_move, params: user_params
        expect(response.body).to eq "{\"move\":0}"
      end

      it 'returns the first available spot on the board' do
        user_params = {board: '{"moves": [{"player_one":"5"}, {"player_two":"0"}]}'}
        get :get_move, params: user_params
        expect(response.body).to eq "{\"move\":1}"
      end

    end

    context 'writing to the database' do

      it 'does not write to the database if no query params are given' do
        get :get_move
        moves = MoveRequest.all
        expect(moves.length).to eq 0
      end

      it 'writes a record to the database after the response is sent' do
        user_params = {board: '{"moves": [{"player_one":"5"}, {"player_two":"0"}]}'}
        get :get_move, params: user_params
        moves = MoveRequest.all
        expect(moves.length).to eq 1
      end

      it 'has the correct query params string' do
        user_params = {board: '{"moves": [{"player_one":"5"}, {"player_two":"0"}]}'}
        get :get_move, params: user_params
        move = MoveRequest.first
        expect(move.query_params).to eq "{\"moves\": [{\"player_one\":\"5\"}, {\"player_two\":\"0\"}]}"
      end

      it 'has the correct IP address' do
        user_params = {board: '{"moves": [{"player_one":"5"}, {"player_two":"0"}]}'}
        get :get_move, params: user_params
        move = MoveRequest.first
        expect(move.ip_address).not_to eq nil
      end

      it 'has the correct move returned to the user' do
        user_params = {board: '{"moves": [{"player_one":"5"}, {"player_two":"0"}]}'}
        get :get_move, params: user_params
        move = MoveRequest.first
        expect(move.returned_move).to eq "1"
      end

    end

  end

end
