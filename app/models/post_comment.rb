class PostComment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  has_many :notifications, dependent: :destroy

  validates :text, presence: true, length: { maximum: 100 }

  def create_notification
    notificatiNotification.where(["visitor_id = ? and visited_id = ? and post_comment_id = ? and action = ? ", 
                        current_api_v1_user.id, post.user_id, id, 'post_comment'])

    if
end
