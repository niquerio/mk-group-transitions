class BallotsController < ApplicationController
  def build
    @ballot = BallotBuilder.new(member_number: params[:member_number], poll: Poll.find(params[:poll_id]))
    render 'new.html.erb'
  end
  def create
    ballot = Ballot.new(ballot_params) 
    ballot.save
  end
  private
  def ballot_params
    params.permit(:poll_id, :member_number, :sca_name, :modern_name, :comment, scores_attributes: [:id, :candidate_id, :value])
  end
end
