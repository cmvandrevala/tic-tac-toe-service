feature "user retrieves running log data" do

  scenario "there are no rows in the database" do
    visit '/api/running_log'

    expect(page).to have_http_status 200
    expect(page.body).to eq "{\"statistics\": []}"
  end

  scenario "there is one row in the database" do
    MoveRequest.add_new_row("foo", "bar", "baz")
    visit '/api/running_log'

    expect(page).to have_http_status 200
    expect(page.body).to include "\"query_params\":\"foo\",\"ip_address\":\"bar\",\"returned_move\":\"baz\""
  end

  scenario "there are multiple rows in the database" do
    MoveRequest.add_new_row("foo", "bar", "baz")
    MoveRequest.add_new_row("Bob", "Mary", "Joe")
    visit '/api/running_log'

    expect(page).to have_http_status 200
    expect(page.body).to include "\"query_params\":\"foo\",\"ip_address\":\"bar\",\"returned_move\":\"baz\""
    expect(page.body).to include "\"query_params\":\"Bob\",\"ip_address\":\"Mary\",\"returned_move\":\"Joe\""
  end

end
