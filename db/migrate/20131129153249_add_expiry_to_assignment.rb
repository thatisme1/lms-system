class AddExpiryToAssignment < ActiveRecord::Migration
  def change
    add_column :assignments, :expired, :boolean
  end
end
