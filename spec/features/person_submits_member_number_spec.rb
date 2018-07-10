require 'rails_helper'

RSpec.feature "person submits member number" do
  scenario "they are a valid resident member and are given appropriate ballot" do
    group = create(:group, name: 'Barony of Nowhere')
    zipcode = create(:zipcode)
    zipcode.groups << group
    poll = create(:current_poll, group: group) 
    ticket = create(:ticket, poll: poll)
    candidate = create(:candidate, sca_name: "Lady Ruby", ticket: ticket)
    candidate1 = create(:candidate, sca_name: "Lord Emerald", ticket: ticket)
    member = create(:member, sca_name: 'Lady Flilda', modern_name: 'Mattie Molificent', number: 555555, zipcode: zipcode) 

    visit poll_path(poll.id)
    fill_in "member_number", with: member.number
		fill_in "sca_name", with: member.sca_name
		fill_in "modern_name", with: member.modern_name
		fill_in "zipcode", with: member.zipcode

    click_on "Get Ballot"
    expect(page).to have_text member.sca_name
    expect(page).to have_text member.modern_name
    expect(page).to have_text member.zipcode
    expect(page).to have_text member.number
    expect(page).to have_text "Resident Member Ballot"
    expect(page).to have_text candidate.sca_name
    expect(page).to have_text candidate1.sca_name
  end

    
  scenario 'they select valid content' do
    group = create(:group, name: 'Barony of Nowhere')
    zipcode = create(:zipcode)
    zipcode.groups << group
    poll = create(:current_poll, group: group) 
    ticket = create(:ticket, poll: poll)
    candidate = create(:candidate, sca_name: "Lady Ruby", ticket: ticket)
    candidate1 = create(:candidate, sca_name: "Lord Emerald", ticket: ticket)
    member = create(:member, sca_name: 'Lady Flilda', modern_name: 'Mattie Molificent', number: 555555, zipcode: zipcode) 

    visit poll_path(poll.id)
    fill_in "member_number", with: member.number
		fill_in "sca_name", with: member.sca_name
		fill_in "modern_name", with: member.modern_name
		fill_in "zipcode", with: member.zipcode
    click_on "Get Ballot"

    choose "scores_attributes[0][value]_3"
    choose "scores_attributes[1][value]_2"
    comment = 'This is a long comment'
    fill_in "comment", with: comment

    click_on "Submit Poll Response"
    ballot = Ballot.first
    expect(Score.count).to eq(2)
    expect(Ballot.count).to eq(1)
    expect(ballot.sca_name).to eq(member.sca_name)
    expect(ballot.modern_name).to eq(member.modern_name)
    expect(ballot.member_number).to eq(member.number)
    expect(ballot.zipcode).to eq(member.zipcode.number)
    expect(ballot.comment).to eq(comment)
    expect(ballot.scores.find_by(candidate_id: candidate.id).value).to eq(3)
    expect(ballot.scores.find_by(candidate_id: candidate1.id).value).to eq(2)
		expect(page).to have_current_path('/')
    expect(page).to have_content('Middle Kingdom Group Transition')
    expect(page).to have_content('Your ballot has been successfully submitted')
  end 
end
