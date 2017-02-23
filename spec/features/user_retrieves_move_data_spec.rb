feature "user retrieves move data" do

  scenario "she sends in a board with two moves" do
    visit '/api/computer_move?board={%22moves%22:%20[{%22player_one%22:%220%22},{%22player_two%22:%221%22}]}'

    expect(page).to have_http_status 200
    expect(page.body).to eq JSON.generate({move: 2})
    expect(MoveRequest.retrieve_all_data.length).to eq 1
  end

end
