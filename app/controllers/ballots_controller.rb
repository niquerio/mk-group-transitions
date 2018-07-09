class BallotsController < ApplicationController
	def new
		set_session
    b = Ballot.new(member_number: session[:member_number], poll: Poll.find(session[:poll_id]))
    @ballot = BallotPresenter.new(b)
	end
  def create
    ballot = Ballot.new(ballot_params) 
    ballot.save
		reset_session
  end
  private
  def ballot_params
    h = params.permit(:sca_name, :modern_name, :comment, scores_attributes: [:id, :candidate_id, :value]).to_h
	  h.merge({member_number: session[:member_number], poll_id: session[:poll_id]})	
  end

  def set_session
		session[:member_number] = params[:member_number]
		session[:poll_id] = params[:poll_id]
	end

end
