class AddInfosToCards < ActiveRecord::Migration
  def change
    add_column :cards, :imas_hash, :string
    add_column :cards, :imas_id, :integer
  end
end
