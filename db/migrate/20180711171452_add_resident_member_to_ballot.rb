class AddResidentMemberToBallot < ActiveRecord::Migration[5.2]
  def change
    add_column :ballots, :resident_member, :boolean
  end
end
