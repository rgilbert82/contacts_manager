class Todo < ActiveRecord::Base
  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'

  validates :title, presence: true
  validates :start_time, presence: true
end
