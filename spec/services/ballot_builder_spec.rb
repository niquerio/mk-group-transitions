require 'rails_helper'
require 'ballot_builder'
describe BallotBuilder, 'initialize' do
  it 'initializes with poll' do
    poll = create(:current_poll)
    ballot = BallotBuilder.new(poll: poll, member_number: nil) 
    expect(ballot.poll).to eq(poll)
  end   
  it "rejects empty params" do
    expect{BallotBuilder.new()}.to raise_error(ArgumentError)
  end
end
describe BallotBuilder, 'behavior' do
  context 'nil member_number' do
    before(:each) do
      poll = create(:current_poll)
      @ballot = BallotBuilder.new(poll: poll, member_number: nil)
    end
    it 'has empty string sca_name' do
      expect(@ballot.sca_name).to eq('')      
    end
    it 'has empty string modern_name' do
      expect(@ballot.modern_name).to eq('')      
    end
    it 'has empty string comment' do
      expect(@ballot.comment).to eq('')      
    end
    it 'resident_member is false' do
      expect(@ballot.resident_member).to be_falsy     
    end
  end
  context 'valid member_number with matching zipcode' do
    before(:each) do
      group = create(:group, name: 'Barony of Nowhere')
      z = create(:zipcode)
      group.zipcodes << z
      poll = create(:current_poll, group: group)
      @member = create(:member, sca_name: 'Molly Madrigal', modern_name: 'Tricia Modern', zipcode: z, number: 123456)
      @ballot = BallotBuilder.new(poll: poll, member_number: @member.number)
    end
    it 'has member number' do
      expect(@ballot.member_number).to eq(@member.number)      
    end
    it 'has empty string sca_name' do
      expect(@ballot.sca_name).to eq(@member.sca_name)      
    end
    it 'has empty string modern_name' do
      expect(@ballot.modern_name).to eq(@member.modern_name)      
    end
    it 'has empty string comment' do
      expect(@ballot.comment).to eq('')      
    end
    it 'resident_member is true' do
      expect(@ballot.resident_member).to be_truthy     
    end
  end
end
describe BallotBuilder, '' do
end
