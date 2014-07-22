class RemoveAssignmentIdFromAttempt < ActiveRecord::Migration
  def up
    remove_column :attempts ,:assignment_id
    add_column :attempts , :question_id ,:integer
    add_column :attempts , :choice_id , :integer
  end

  def down
  end
end
