require 'computer_player'

class MockController
  include ComputerPlayer
end

describe ComputerPlayer do

  before(:each) do
    @controller = MockController.new
  end

  describe 'move' do

    it 'returns the first cell on an empty board' do
      board = []
      expect(@controller.move(board)).to eq 0
    end

    it 'returns the first cell if it is available' do
      board = [{player_one: 5}, {player_two: 7}, {player_one: 8}]
      expect(@controller.move(board)).to eq 0
    end

    it 'returns the second cell if the first one is taken' do
      board = [{player_one: 0}, {player_two: 7}, {player_one: 8}]
      expect(@controller.move(board)).to eq 1
    end

    it 'returns the third cell if the first two are taken' do
      board = [{player_one: 0}, {player_two: 7}, {player_one: 8}, {player_one: 1}]
      expect(@controller.move(board)).to eq 2
    end

    it 'returns a cell in the middle of the board' do
      board = [{player_one: 0}, {player_two: 2}, {player_two: 7}, {player_one: 8}, {player_two: 4}, {player_one: 1}]
      expect(@controller.move(board)).to eq 3
    end

    it 'returns the final cell of the board' do
      board = [{p1: 0}, {p2: 2}, {p1: 7}, {p2: 6}, {p1: 3}, {p2: 4}, {p1: 5}, {p2: 1}]
      expect(@controller.move(board)).to eq 8
    end

  end

  describe 'json string to hash array' do

    it 'returns an empty array given an empty array input' do
      json_string = '{"moves":[]}'
      expect(@controller.parse_json(json_string)).to eq []
    end

    it 'parses an array with one move' do
      json_string = '{"moves":[{"player_one":"5"}]}'
      expect(@controller.parse_json(json_string)).to eq [{player_one: 5}]
    end

    it 'parses an array with a different move' do
      json_string = '{"moves":[{"player_two":"1"}]}'
      expect(@controller.parse_json(json_string)).to eq [{player_two: 1}]
    end

    it 'parses an array with two moves' do
      json_string = '{"moves":[{"player_two":"2"}, {"player_one":"0"}]}'
      expect(@controller.parse_json(json_string)).to eq [{player_two: 2}, {player_one: 0}]
    end

    it 'parses an array with many moves' do
      json_string = '{"moves":[{"player_two": "4"}, {"player_one": "5"}, {"player_one": "6"}]}'
      expect(@controller.parse_json(json_string)).to eq [{player_two: 4}, {player_one: 5}, {player_one: 6}]
    end

  end
end
