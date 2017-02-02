feature "user retrieves running log data" do

  scenario "there are no rows in the database" do
    visit '/api/running_log'

    expect(page).to have_http_status 200
    expect(page.body).to eq "{\"statistics\": []}"
  end

  scenario "there is one row in the database" do
    MoveRequest.add_new_row("foo", "bar", "baz", "quo")
    visit '/api/running_log'

    expect(page).to have_http_status 200
    expect(page.body).to include "\"query_params\":\"foo\",\"ip_address\":\"bar\",\"returned_move\":\"baz\",\"client_name\":\"quo\""
  end

  scenario "there are multiple rows in the database" do
    MoveRequest.add_new_row("foo", "bar", "baz", "quib")
    MoveRequest.add_new_row("Bob", "Mary", "Joe", "Sam")
    visit '/api/running_log'

    expect(page).to have_http_status 200
    expect(page.body).to include "\"query_params\":\"foo\",\"ip_address\":\"bar\",\"returned_move\":\"baz\",\"client_name\":\"quib\""
    expect(page.body).to include "\"query_params\":\"Bob\",\"ip_address\":\"Mary\",\"returned_move\":\"Joe\",\"client_name\":\"Sam\""
  end

end
