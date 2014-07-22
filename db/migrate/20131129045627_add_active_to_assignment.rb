class AddActiveToAssignment < ActiveRecord::Migration
  def change
    add_column :assignments, :active, :boolean
  end
end
