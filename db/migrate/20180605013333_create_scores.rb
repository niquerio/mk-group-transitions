class CreateScores < ActiveRecord::Migration[5.2]
  def change
    create_table :scores do |t|
      t.references :candidate, foreign_key: true
      t.references :ballot, foreign_key: true
      t.integer :value

      t.timestamps
    end
  end
end
