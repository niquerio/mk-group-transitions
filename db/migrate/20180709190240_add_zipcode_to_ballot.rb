class AddZipcodeToBallot < ActiveRecord::Migration[5.2]
  def change
    add_column :ballots, :zipcode, :integer
  end
end
