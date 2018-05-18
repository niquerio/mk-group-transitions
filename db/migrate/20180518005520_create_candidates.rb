class CreateCandidates < ActiveRecord::Migration[5.2]
  def change
    create_table :candidates do |t|
      t.string :sca_name
      t.references :ticket, foreign_key: true
    end
  end
end
