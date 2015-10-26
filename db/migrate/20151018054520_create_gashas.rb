class CreateGashas < ActiveRecord::Migration
  def change
    create_table :gashas do |t|
      t.references :user, index: true, foreign_key: true
      t.references :cards, index: true, foreign_key: true
      t.string :commit_id

      t.timestamps null: false
    end
    add_index :gashas , [:commit_id], unique: true
  end
end