require "rails_helper"
describe "get /polls/:id" do
  context "Baronial leadership poll" do
    it "shows name of group associated with the poll; title of poll" do
      group = create(:group, name: 'Barony of Nowhere')
      poll = create(:current_poll, group: group) 
      get "/polls/#{poll.id}"
      expect(response).to have_http_status(200)
      expect(response.body).to include('Barony of Nowhere')
    end
  end
end
