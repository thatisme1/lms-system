class RemoveUserFromAssignment < ActiveRecord::Migration
  def up
    remove_column :assignments ,:user_id
    remove_column :attempts , :question_id
    remove_column :attempts ,:score
    remove_column :attempts ,:choice_id
    add_column :attempts,:assignment_id ,:integer

  end

  def down
  end
end
