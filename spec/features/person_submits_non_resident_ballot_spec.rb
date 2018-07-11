require 'rails_helper'

RSpec.feature "person submits non-resident-member ballot" do
  scenario "they click the link to go non-resident-member ballot" do
    group = create(:group, name: 'Barony of Nowhere')
    zipcode = create(:zipcode)
    zipcode.groups << group
    poll = create(:current_poll, group: group) 
    ticket = create(:ticket, poll: poll)
    candidate = create(:candidate, sca_name: "Lady Ruby", ticket: ticket)
    candidate1 = create(:candidate, sca_name: "Lord Emerald", ticket: ticket)
    visit poll_path(poll.id)
    click_on "Click for Non-Resident/Non-Member Poll" 
    expect(page).to have_text "Non-Resident/Non-Member Ballot"
  end

  scenario "they submit valid content" do
    group = create(:group, name: 'Barony of Nowhere')
    zipcode = create(:zipcode)
    zipcode.groups << group
    poll = create(:current_poll, group: group) 
    ticket = create(:ticket, poll: poll)
    candidate = create(:candidate, sca_name: "Lady Ruby", ticket: ticket)
    candidate1 = create(:candidate, sca_name: "Lord Emerald", ticket: ticket)
    sca_name = 'Molly Madgrigal'
    modern_name = 'Martha Smith'
    zipcode = 90210

    visit poll_path(poll.id)
    click_on "Click for Non-Resident/Non-Member Poll" 

		fill_in "sca_name", with: sca_name
		fill_in "modern_name", with: modern_name
		fill_in "zipcode", with: zipcode

    choose "scores_attributes[0][value]_4"
    choose "scores_attributes[1][value]_1"
    comment = 'This is a new long comment'
    fill_in "comment", with: comment

    click_on "Submit Poll Response"
    ballot = Ballot.first
    expect(Score.count).to eq(2)
    expect(Ballot.count).to eq(1)
    expect(ballot.sca_name).to eq(sca_name)
    expect(ballot.modern_name).to eq(modern_name)
    expect(ballot.zipcode).to eq(zipcode)
    expect(ballot.comment).to eq(comment)
    expect(ballot.resident_member).to eq(false)
    expect(ballot.scores.find_by(candidate_id: candidate.id).value).to eq(4)
    expect(ballot.scores.find_by(candidate_id: candidate1.id).value).to eq(1)
		expect(page).to have_current_path('/')
    expect(page).to have_content('Middle Kingdom Group Transition')
    expect(page).to have_content('Your ballot has been successfully submitted')
  end
end
