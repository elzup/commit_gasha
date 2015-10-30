class AddTurnedToGashas < ActiveRecord::Migration
  def change
    add_column :gashas, :turned, :boolean
  end
end
