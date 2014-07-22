class AddClassToUser < ActiveRecord::Migration
  def change
    add_column :users, :class_id, :integer
  end
end
