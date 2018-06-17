class BallotPresenter
  extend Forwardable
	def_delegators :@ballot, :poll, :comment, :member_number

  def initialize(ballot)  
		@ballot = ballot
		@member = Member.find_by(number: ballot.member_number)
  end
	
	def sca_name
		@member&.sca_name || @ballot.sca_name 
	end

	def modern_name
		@member&.modern_name || @ballot.sca_name
	end

	def tickets
	  @ballot.poll&.tickets	
	end

	def resident_member
    @member and @ballot.poll.group.zipcodes.include?(@member.zipcode) 
	end
  
end
