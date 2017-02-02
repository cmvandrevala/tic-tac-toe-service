feature "the user counts the number of times an endpoint has been hit" do

  scenario "nobody has hit the endpoint (the database is empty)" do
    visit "/api/endpoints_hit"

    expect(page).to have_http_status 200
    expect(page.body).to eq "{\"endpoints\": []}"
  end





end
