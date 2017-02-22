module ComputerPlayer

  BOARD_CELLS = (0..8).to_a

  def move(board)
    (BOARD_CELLS - board.map { |move| move.values.first }).min
  end

  def parse_json(str)
    json_to_hash = JSON.parse(str)["moves"]
    json_to_hash.map { |x| { x.keys.first.to_sym => x.values.first.to_i } }
  end

end
