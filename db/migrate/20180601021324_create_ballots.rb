class CreateBallots < ActiveRecord::Migration[5.2]
  def change
    create_table :ballots do |t|
      t.integer :member_number
      t.references :poll, foreign_key: true
      t.string :sca_name
      t.string :modern_name
      t.text :comment

      t.timestamps
    end
  end
end
