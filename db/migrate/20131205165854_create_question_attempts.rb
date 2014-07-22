class CreateQuestionAttempts < ActiveRecord::Migration
  def change
    create_table :question_attempts do |t|
      t.integer :question_id
      t.integer :attempt_id
      t.integer :choice_id
      t.timestamps
    end
  end
end
