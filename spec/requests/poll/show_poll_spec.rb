require "rails_helper"
describe "get /polls/:id" do
  context "Baronial leadership poll" do
    it "shows name of group associated with the poll and poll close date" do
      group = create(:group, name: 'Barony of Nowhere')
      poll = create(:current_poll, group: group) 
      get "/polls/#{poll.id}"
      expect(response).to have_http_status(200)
      expect(response.body).to include('Barony of Nowhere')
      expect(response.body).to include(poll.end_date.strftime('%A, %b %d, %Y @ %l:%M %p'))
    end
    it "shows tickets associated with a given poll" do
      group = create(:group, name: 'Barony of Nowhere')
      poll = create(:current_poll, group: group) 
      ticket = create(:ticket, poll: poll)
      ticket2 = create(:ticket, poll: poll)
      candidate = create(:candidate, sca_name: "Lady Ruby", ticket: ticket)
      candidate = create(:candidate, sca_name: "Lord Emerald", ticket: ticket)
      candidate = create(:candidate, sca_name: "Sir Diamond", ticket: ticket2)
     
      get "/polls/#{poll.id}"
      expect(response.body).to include('Lady Ruby')
      expect(response.body).to include('Lord Emerald')
      expect(response.body).to include('Sir Diamond')
 
    end
    
  end
end
