class ResidenceValidator
  def initialize(poll:, member_number: nil, sca_name: nil, modern_name: nil, zipcode: nil)
    @poll = poll
    @member_number = member_number
    @sca_name = sca_name
    @modern_name = modern_name
    @zipcode = Zipcode.find_by(number: zipcode)

    @member = Member.find_by(number: @member_number, sca_name: @sca_name, modern_name: @modern_name, zipcode: @zipcode) 
  end

  def resident_member?
    @member and @poll.group.zipcodes.include?(@zipcode)
  end
end
