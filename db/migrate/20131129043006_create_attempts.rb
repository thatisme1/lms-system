class CreateAttempts < ActiveRecord::Migration
  def change
    create_table :attempts do |t|
      t.integer :assignment_id
      t.integer :score
      t.integer	:user_id
      t.timestamps
    end
  end
end
