class Attempt < ActiveRecord::Base
  belongs_to :user
  belongs_to :assignment
  has_many :question_attempts,:dependent => :destroy

  validates :user_id,:presence=>:true
  validates :assignment_id,:presence=>:true
  validates :assignment_id ,:uniqueness => :true


  attr_accessible  :assignment_id,:user_id



  def check_already_done
  	valid=find_by_user_id_and_assignment_id(self.user_id,self.assignment_id).nil?
  	self.errors.add(:user_id,'asdas') if !valid

  end

  def score
    sc=0
    puts 'herhe==========================================================='
    self.question_attempts.each do |q|

      if (q.choice_id == q.question.choice_id)
        sc=sc+1
      end
    end
    puts sc.to_s
    return sc
  end

end
