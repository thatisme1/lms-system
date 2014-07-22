class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :text
      t.integer :assignment_id
      t.integer :choice_id
      t.timestamps
    end
  end
end
