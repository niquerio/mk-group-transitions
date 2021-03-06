require 'rails_helper'
require 'ballot_presenter'
describe BallotPresenter, 'initialize' do
  it 'initializes with poll' do
    poll = create(:current_poll)
    ballot = Ballot.new(poll: poll)
    bp = BallotPresenter.new(ballot) 
    expect(bp.poll).to eq(poll)
  end   
  it "rejects empty params" do
    expect{BallotPresenter.new()}.to raise_error(ArgumentError)
  end
end
describe BallotPresenter, 'behavior' do
  context 'nil member_number' do
    before(:each) do
      poll = create(:current_poll)
      ballot = Ballot.new(poll: poll) 
      @bp = BallotPresenter.new(ballot)
    end
    it 'has empty string sca_name' do
      expect(@bp.sca_name).to eq('')      
    end
    it 'has empty string modern_name' do
      expect(@bp.modern_name).to eq('')      
    end
    it 'has empty string comment' do
      expect(@bp.comment).to eq('')      
    end
  end
  context 'valid member info with matching zipcode' do
    before(:each) do
      group = create(:group, name: 'Barony of Nowhere')
      z = create(:zipcode)
      group.zipcodes << z
      poll = create(:current_poll, group: group)
      @member = create(:member, sca_name: 'Molly Madrigal', modern_name: 'Tricia Modern', zipcode: z, number: 123456)
      ballot = Ballot.new(poll: poll, member_number: @member.number, sca_name: @member.sca_name, modern_name: @member.modern_name, zipcode: @member.zipcode.number)
      @bp = BallotPresenter.new(ballot)
    end
    it 'has member number' do
      expect(@bp.member_number).to eq(@member.number)      
    end
    it 'has empty string sca_name' do
      expect(@bp.sca_name).to eq(@member.sca_name)      
    end
    it 'has empty string modern_name' do
      expect(@bp.modern_name).to eq(@member.modern_name)      
    end
    it 'has empty string comment' do
      expect(@bp.comment).to eq('')      
    end
  end
end
describe BallotPresenter, '' do
end
