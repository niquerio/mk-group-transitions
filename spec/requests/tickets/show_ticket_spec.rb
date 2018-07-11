require "rails_helper"
describe "get /tickets/:id" do
  context "Ticket in Baronial leadership poll" do
    before(:each) do
      @group = create(:group, name: 'Barony of Nowhere')
      @poll = create(:current_poll, group: @group) 
      @ticket = create(:ticket, poll: @poll)
      @candidate1 = create(:candidate, sca_name: "Lady Ruby", ticket: @ticket)
      @candidate2 = create(:candidate, sca_name: "Lord Emerald", ticket: @ticket)
    end
    it "shows name of group associated with the poll" do
      get "/tickets/#{@ticket.id}"
      expect(response).to have_http_status(200)
      expect(response.body).to include(@group.name)
    end
    it "shows names of candidates of ticket and letter of intent" do
      get "/tickets/#{@ticket.id}"
      expect(response.body).to include(@candidate1.sca_name)
      expect(response.body).to include(@candidate2.sca_name)
      expect(response.body).to include(@ticket.letter_of_intent)
    end
  end
end
