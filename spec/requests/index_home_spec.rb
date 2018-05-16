require "rails_helper"
describe "Get /" do
  it "shows home page" do
    get "/"
    expect(response).to have_http_status(200)
    expect(response.body).to include('Middle Kingdom Group Transitions')
  end

  it "shows groups with active polls" do
    active_poll_group = create(:group, name: 'Barony of Cynnabar')
    inactive_poll_group = create(:group, name: 'Barony of Northwoods')
    poll = create(:current_poll, group: active_poll_group) 
    get "/"
    expect(response.body).to include('Cynnabar')
    expect(response.body).not_to include('Northwoods')

  end
end
