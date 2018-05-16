class CreateZipcodes < ActiveRecord::Migration[5.2]
  def change
    create_table :zipcodes do |t|
      t.integer :number

      t.timestamps
    end
  end
end
