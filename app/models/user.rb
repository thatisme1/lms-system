class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable

  belongs_to :role

  has_many :attempts, :dependent=>:destroy
  devise :database_authenticatable,
         :recoverable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation,:role_id
  # attr_accessible :title, :body

  def available_assignments
    avail=self.attempts.select(:assignment_id).map(&:assignment_id)
    avail = '' if !avail.any?
    Assignment.where( 'active = ? and expired = ? and id not in (?)',true,false,avail )
  end

  def answer_choice(assignment_id,question_id)
    att=self.attempts.find_by_assignment_id(assignment_id)
    q_attempt= ''
    q_attempt = att.question_attempts.find_by_question_id(question_id) if att.present?

    (q_attempt.blank? ? '' : q_attempt.choice_id)
  end


end
