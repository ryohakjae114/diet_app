class Post < ApplicationRecord
  belongs_to :user
  has_many :post_comments

  validates :text, presence: true, length: { maximum: 500 }

  def self.all_public_posts
    public_diary_ids      = Diary.where(public_diary: true).pluck(:user_id)
    public_diary_user_ids = User.where(id: public_diary_ids).pluck(:id)
    @posts = Post.where(user_id: public_diary_user_ids)
  end

  def public?
    self.user.diary.public_diary?
  end
end
