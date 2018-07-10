require 'rails_helper'
require 'residence_validator'
describe ResidenceValidator, 'initialize' do
  before(:each) do
    group = create(:group, name: 'Barony of Nowhere')
    z = create(:zipcode)
    group.zipcodes << z
    @poll = create(:current_poll, group: group)
    @member = build(:member, sca_name: 'Molly Madrigal', modern_name: 'Tricia Modern', zipcode: z, number: 123456)
  end
  it 'initializes with poll' do
    rv = ResidenceValidator.new(poll: @poll)
    expect(rv).to be_truthy
  end
  it 'initializes with member_number, sca_name, modern_name, zipcode, poll' do
    rv = ResidenceValidator.new(member_number: @member.number, sca_name: @member.sca_name, modern_name: @member.modern_name, zipcode: @member.zipcode.number, poll: @poll)
    expect(rv).to be_truthy
  end
end
describe ResidenceValidator, 'resident_member?' do
  before(:each) do
    z = create(:zipcode)
    group = create(:group, name: 'Barony of Nowhere')
    group.zipcodes << z
    @poll = create(:current_poll, group: group)
    @member = create(:member, sca_name: 'Molly Madrigal', modern_name: 'Tricia Modern', zipcode: z, number: 123456)
  end
  it "returns true for resident member information" do
    rv = ResidenceValidator.new(member_number: @member.number, sca_name: @member.sca_name, modern_name: @member.modern_name, zipcode: @member.zipcode.number, poll: @poll)
    expect(rv.resident_member?).to be_truthy
  end  
  it "returns false for incorrect member number" do
    rv = ResidenceValidator.new(member_number: 0, sca_name: @member.sca_name, modern_name: @member.modern_name, zipcode: @member.zipcode.number, poll: @poll)
    expect(rv.resident_member?).to be_falsey
  end  
  it "returns false for incorrect sca_name" do
    rv = ResidenceValidator.new(member_number: @member.number, sca_name: nil, modern_name: @member.modern_name, zipcode: @member.zipcode.number, poll: @poll)
    expect(rv.resident_member?).to be_falsey
  end  
  it "returns false for incorrect modern_name" do
    rv = ResidenceValidator.new(member_number: @member.number, sca_name: @member.sca_name, modern_name: nil, zipcode: @member.zipcode.number, poll: @poll)
    expect(rv.resident_member?).to be_falsey
  end  
  it "returns false for incorrect zipcode" do
    rv = ResidenceValidator.new(member_number: @member.number, sca_name: @member.sca_name, modern_name: @member.modern_name, zipcode: 0, poll: @poll)
    expect(rv.resident_member?).to be_falsey
  end  

  it "returns false for valid member but not a polling zipcode" do
    z = create(:zipcode, number: 5555)
    @member.update(zipcode: z)
    rv = ResidenceValidator.new(member_number: @member.number, sca_name: @member.sca_name, modern_name: @member.modern_name, zipcode: @member.zipcode.number, poll: @poll)
    expect(rv.resident_member?).to be_falsey
  end

end
