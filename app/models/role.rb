class Role < ActiveRecord::Base
	has_many :users
  attr_accessible :name
  def is(string)
    self.name==string
  end
end
