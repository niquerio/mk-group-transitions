class BallotPresenter
  extend Forwardable
	def_delegators :@ballot, :poll, :comment, :member_number, :sca_name, :modern_name, :zipcode

  def initialize(ballot)  
		@ballot = ballot
  end
	
	def tickets
	  @ballot.poll&.tickets	
	end
  
end
