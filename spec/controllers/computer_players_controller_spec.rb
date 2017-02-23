require 'computer_players_controller'

describe ComputerPlayersController do

  describe 'getting a move' do

    context 'first available spot computer player' do

      it 'returns a status code of 204 if no params are given' do
        get :computer_move
        expect(response).to have_http_status 204
      end

      it 'returns a status code of 200 if a current board is given' do
        get :computer_move, params: {board: JSON.generate({moves: [{player_one: "1"}, {player_two: "5"}]})}
        expect(response).to have_http_status 200
      end

      it 'returns a status code of 204 if a current board is not given' do
        user_params = {random_params: JSON.generate({random1: "param1", random2: "param2"})}
        get :computer_move, params: user_params
        expect(response).to have_http_status 204
      end

      it 'returns cell zero if the board is empty' do
        user_params = {board: JSON.generate({moves: []})}
        get :computer_move, params: user_params
        expect(response.body).to eq JSON.generate({move: 0})
      end

      it 'returns cell zero if the first spot is available' do
        user_params = {board: JSON.generate({moves: [{player_one: "5"}]})}
        get :computer_move, params: user_params
        expect(response.body).to eq JSON.generate({move: 0})
      end

      it 'returns the first available spot on the board' do
        user_params = {board: JSON.generate({moves: [{player_one: "5"}, {player_two: "0"}]})}
        get :computer_move, params: user_params
        expect(response.body).to eq JSON.generate({move: 1})
      end

    end

  end

end
