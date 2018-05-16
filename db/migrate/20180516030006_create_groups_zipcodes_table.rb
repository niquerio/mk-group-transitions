class CreateGroupsZipcodesTable < ActiveRecord::Migration[5.2]
  def change
    create_table :groups_zipcodes, id: false do |t|
      t.belongs_to :group, index: true 
      t.belongs_to :zipcode, index: true 
    end
  end
end
