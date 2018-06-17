require 'rails_helper'
RSpec.describe Ballot, 'init' do
  it "initializes Ballot with correct defaults" do
    ballot = Ballot.new
    expect(ballot.sca_name).to eq('')
    expect(ballot.modern_name).to eq('')
    expect(ballot.comment).to eq('')
  end
end
