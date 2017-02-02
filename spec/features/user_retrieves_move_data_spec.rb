require "computer_players_controller"

feature "user retrieves move data" do

  scenario "they send in no query params" do
    visit '/api/get_move'

    expect(page).to have_http_status 204
    expect(page.body).to eq ""
    expect(MoveRequest.retrieve_all_data.length).to eq 0
  end

end
