class CreateBeeps < ActiveRecord::Migration[7.1]
  def change
    create_table :beeps do |t|
      t.integer :pokemon_id
      t.datetime :timestamp
      t.integer :kind

      t.timestamps
    end
  end
end
