class BallotPresenter
  extend Forwardable
	def_delegators :@ballot, :poll, :comment, :member_number, :sca_name, :modern_name, :zipcode, :resident_member

  def initialize(ballot)  
		@ballot = ballot
  end
	
	def tickets
	  @ballot.poll&.tickets	
	end

  def resident_member?
    resident_member
  end
  
end
