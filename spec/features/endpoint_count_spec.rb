feature "the user counts the number of times an endpoint has been hit" do

  scenario "nobody has visited the endpoint" do
    visit "/api/endpoints_hit"

    expect(page).to have_http_status 200
    expect(page.body).to eq "{\"/api/computer_move\": []}"
  end

  scenario "one user visited the endpoint with no params" do
    visit '/api/computer_move'

    expect(page).to have_http_status 204
    expect(page.body).to eq ""

    visit "/api/endpoints_hit"

    expect(page).to have_http_status 200
    expect(page.body).to eq "{\"/api/computer_move\": []}"
  end

  scenario "one user visited the endpoint with appropriate params" do
    visit '/api/computer_move?client_name=John&board={%22moves%22:%20[{%22player_one%22:%220%22}]}'

    expect(page).to have_http_status 200
    expect(page.body).to eq "{\"move\":1}"

    visit "/api/endpoints_hit"

    expect(page).to have_http_status 200
    expect(page.body).to eq "{\"/api/computer_move\": [{\"client_name\":\"John\",\"count\":1}]}"
  end

  scenario "one user visited the endpoint multiple times" do

    13.times do
      visit '/api/computer_move?client_name=Bob&board={%22moves%22:%20[{%22player_one%22:%220%22}]}'
    end

    visit "/api/endpoints_hit"

    expect(page).to have_http_status 200
    expect(page.body).to eq "{\"/api/computer_move\": [{\"client_name\":\"Bob\",\"count\":13}]}"
  end

  scenario "multiple users visit the site" do

    7.times do
      visit '/api/computer_move?client_name=Bob&board={%22moves%22:%20[{%22player_one%22:%220%22}]}'
    end

    12.times do
      visit '/api/computer_move?client_name=Sarah&board={%22moves%22:%20[{%22player_one%22:%220%22}]}'
    end

    2.times do
      visit '/api/computer_move?client_name=Sam&board={%22moves%22:%20[{%22player_one%22:%220%22}]}'
    end

    visit "/api/endpoints_hit"

    expect(page).to have_http_status 200
    expect(page.body).to eq "{\"/api/computer_move\": [{\"client_name\":\"Sarah\",\"count\":12},{\"client_name\":\"Sam\",\"count\":2},{\"client_name\":\"Bob\",\"count\":7}]}"
  end

end
