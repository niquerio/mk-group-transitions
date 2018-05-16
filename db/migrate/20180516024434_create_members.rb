class CreateMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :members do |t|
      t.string :sca_name
      t.string :modern_name
      t.integer :number
      t.references :zipcode, foreign_key: true

      t.timestamps
    end
  end
end
