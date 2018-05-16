require 'rails_helper'

RSpec.describe Poll, type: :model do
  it 'does not accept end_dates after start_dates' do
    poll = build(:poll, start_date: DateTime.now + 2.days, end_date: DateTime.now + 1.days)
    expect(poll.valid?).to be_falsey
  end

  it 'does not accept start_dates in the past' do
    poll = build(:poll, start_date: DateTime.now - 3.day, end_date: DateTime.now + 1.day)
    expect(poll.valid?).to be_falsey
  end
end

RSpec.describe Poll, 'self.current' do
  it "returns list of current polls" do
    poll1 = create(:current_poll)
    poll2 = create(:current_poll)
    poll3 = create(:future_poll) 
    expect(Poll.current.count).to eq(2)
  end 
end
