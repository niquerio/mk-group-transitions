class BallotsController < ApplicationController
	def new
		set_session
    if ResidenceValidator.new(member_number: session[:member_number], poll: Poll.find(session[:poll_id]), sca_name: session[:sca_name], modern_name: session[:modern_name], zipcode: session[:zipcode]).resident_member?
      b = Ballot.new(member_number: session[:member_number], poll: Poll.find(session[:poll_id]), sca_name: session[:sca_name], modern_name: session[:modern_name], zipcode: session[:zipcode])
      @ballot = BallotPresenter.new(b)
    end
	end
  def create
    ballot = Ballot.new(ballot_params) 
    if ballot.save
		  reset_session
      flash[:success] = 'Your ballot has been successfully submitted'
      redirect_to '/'
    end
  end
  private
  def ballot_params
    h = params.permit(:comment, scores_attributes: [:id, :candidate_id, :value]).to_h
	  h.merge({member_number: session[:member_number], poll_id: session[:poll_id], sca_name: session[:sca_name],
      modern_name: session[:modern_name], zipcode: session[:zipcode]})	
  end

  def set_session
		session[:member_number] = params[:member_number]
		session[:poll_id] = params[:poll_id]
    session[:sca_name] = params[:sca_name]
    session[:modern_name] = params[:modern_name]
    session[:zipcode] = params[:zipcode]
	end

end
