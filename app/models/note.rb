class Note < ActiveRecord::Base
  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'

  validates :title, presence: true
  validates :body, presence: true

  def start_time
    self.created_at
  end
end
