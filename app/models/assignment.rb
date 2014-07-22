class Assignment < ActiveRecord::Base
  belongs_to :user
  has_many :questions,:dependent => :destroy
  has_many :attempts ,:dependent => :destroy
  accepts_nested_attributes_for :questions, :reject_if => lambda { |a| a[:text].blank? }, :allow_destroy => true
  attr_accessible  :name ,:questions_attributes



  after_create :inactive

  def can_destroy
    if self.active==true || self.expired==true
     false
    end
    true
  end



  def inactive
    self.active=false
    self.expired=false
    self.save
  end

  def set_as_active
    valid= true
    self.questions.each do |f|
      valid=valid&&f.choices.find_by_id(f.choice_id).present?
    end
    if valid
      self.active=true
      self.save
      return true
    end
    false
  end
  def expire
    self.expired=true
    self.active=false
    self.save
  end
  def check_user
    valid=self.user.role.present? && self.user.role.is('teacher')
    self.errors.add(:user_id,'must be teacher') unless valid
  end

  def close
    self.expired=true
    self.active=false
    self.save
  end

  def as_file
    a=1
    output = [self.id.to_s]
    output.join("\r\n")
    output << self.name
    output.join("\r\n")
    output << self.questions.count.to_s
    output.join("\r\n")
    self.questions.each do |question|
      output << a.to_s
      output.join("\r\n")
      output << question.text
      output.join("\r\n")
      output << question.choices.count.to_s
      output.join("\r\n")
      question.choices.each do |choice|
        output << choice.id.to_s
        output << choice.text

      end
      a=a+1
    end
    output.join("\r\n")
  end




end
