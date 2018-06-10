class BallotBuilder
  attr_reader :poll
  attr_reader :member_number
  attr_reader :sca_name
  attr_reader :modern_name
  attr_reader :comment
  attr_reader :resident_member
  attr_reader :tickets
  def initialize(member_number:, poll:)  
    @poll = poll
    @member_number = member_number
    @comment = '' 
    @sca_name = ''; 
    @modern_name = '';
    @resident_member = false
    @tickets = @poll.tickets
    populate_ballot
  end

  
  private
  def populate_ballot
    member = Member.find_by(number: @member_number)
    if !member.nil? and @poll.group.zipcodes.include?(member.zipcode) 
      @resident_member = true
      @sca_name = member.sca_name
      @modern_name = member.modern_name 
    end
  end
end
