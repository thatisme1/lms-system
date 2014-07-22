class Question < ActiveRecord::Base
	belongs_to :assignment
	has_many :choices ,:dependent => :destroy
  belongs_to :choice
  has_many :question_attempts,:dependent => :destroy
  has_one :correct_answer ,:class_name => 'choice',:foreign_key => :choice_id
  accepts_nested_attributes_for :choices, :reject_if => lambda { |a| a[:text].blank? }, :allow_destroy => true


  attr_accessible :text ,:choices_attributes ,:choice_id



  def count_responce(ch)
    count=0
    self.question_attempts.each do |att|
      count=count+1 if att.choice_id==ch
    end
    count
  end


end
