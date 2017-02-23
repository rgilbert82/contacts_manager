class Contact < ActiveRecord::Base
  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'

  validates :name, presence: true, uniqueness: true
  validates :email, allow_blank: true, format: { with: /.+@\w+\.\w+/ }
  validates :phone, allow_blank: true, format: { with: /(\d{3}\-\d{3}\-\d{4}|\d{10}|\(\d{3}\)\ *\d{3}\-*\d{4})/ }
end
