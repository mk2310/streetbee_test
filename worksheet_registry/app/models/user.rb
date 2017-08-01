class User < ActiveRecord::Base
  validates :login, presence: true
  validates :password, presence: true
  validates :token, presence: true
end
