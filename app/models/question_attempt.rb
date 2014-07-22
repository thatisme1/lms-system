class QuestionAttempt < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :question
  belongs_to :choice
  belongs_to :attempt

  validates :attempt_id ,:presence => :true
  validates :question_id,:presence => :true
  attr_accessible :question_id,:attempt_id,:choice_id

end
