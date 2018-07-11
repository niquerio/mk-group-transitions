class BallotsController < ApplicationController
  protect_from_forgery except: :new
	def new
		set_session
    b = Ballot.new(poll: Poll.find(params[:poll_id]), resident_member: false)
    rv = ResidenceValidator.new(member_number: params[:member_number], poll: Poll.find(params[:poll_id]), sca_name: params[:sca_name], modern_name: params[:modern_name], zipcode: params[:zipcode])
    if rv.resident_member?
      set_resident_member_session
      b.assign_attributes(member_number: session[:member_number], sca_name: session[:sca_name], modern_name: session[:modern_name], zipcode: session[:zipcode], resident_member: true)
    end
    @ballot = BallotPresenter.new(b)
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
    hash = params.permit(:sca_name, :modern_name, :zipcode, :comment, scores_attributes: [:id, :candidate_id, :value]).to_h
    hash = hash.merge({poll_id: session[:poll_id], resident_member: session[:resident_member]})
    if session[:resident_member]
	    hash = hash.merge({member_number: session[:member_number], sca_name: session[:sca_name],
      modern_name: session[:modern_name], zipcode: session[:zipcode]})	
    end
    hash
  end

  def set_session
		reset_session
		session[:poll_id] = params[:poll_id]
    session[:resident_member] = false
	end

  def set_resident_member_session
		session[:member_number] = params[:member_number]
    session[:sca_name] = params[:sca_name]
    session[:modern_name] = params[:modern_name]
    session[:zipcode] = params[:zipcode]
    session[:resident_member] = true
  end
end
