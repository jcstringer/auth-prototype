class User < ActiveRecord::Base
  attr_accessible :email, :name, :password

  validates :email, uniqueness: true
  validates :email, :name, :password, presence: true
end
