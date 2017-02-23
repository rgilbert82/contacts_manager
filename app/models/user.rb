class User < ActiveRecord::Base
  has_many :contacts, dependent: :destroy
  has_many :notes, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :todos, dependent: :destroy

  has_secure_password validations: false

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, on: :create, length: {minimum: 6}
end
