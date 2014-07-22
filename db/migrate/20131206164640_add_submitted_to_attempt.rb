class AddSubmittedToAttempt < ActiveRecord::Migration
  def change
    add_column :attempts, :submitted, :boolean
  end
end
