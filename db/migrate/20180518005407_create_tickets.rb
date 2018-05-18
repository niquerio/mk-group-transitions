class CreateTickets < ActiveRecord::Migration[5.2]
  def change
    create_table :tickets do |t|
      t.text :letter_of_intent
      t.references :poll, foreign_key: true

      t.timestamps
    end
  end
end
