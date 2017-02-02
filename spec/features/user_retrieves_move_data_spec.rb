feature "user retrieves move data" do

  scenario "he sends in no query params" do
    visit '/api/computer_move'

    expect(page).to have_http_status 204
    expect(page.body).to eq ""
    expect(MoveRequest.retrieve_all_data.length).to eq 0
  end

  scenario "she sends in a board with one move" do
    visit '/api/computer_move?board={%22moves%22:%20[{%22player_one%22:%220%22}]}'
    move = MoveRequest.retrieve_all_data.first

    expect(page).to have_http_status 200
    expect(page.body).to eq "{\"move\":1}"
    expect(MoveRequest.retrieve_all_data.length).to eq 1
    expect(move.query_params).to eq "{\"moves\": [{\"player_one\":\"0\"}]}"
    expect(move.ip_address).not_to eq nil
    expect(move.returned_move).to eq "1"
  end

  scenario "she sends in a board with two moves" do
    visit '/api/computer_move?board={%22moves%22:%20[{%22player_one%22:%220%22},{%22player_two%22:%221%22}]}'

    expect(page).to have_http_status 200
    expect(page.body).to eq "{\"move\":2}"
    expect(MoveRequest.retrieve_all_data.length).to eq 1
  end

end
