# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  enum gender: { male: 0, female: 1 }

  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                  foreign_key: "followed_id",
                                  dependent:   :destroy

  has_many :active_notifications, class_name: 'Notification', 
                                  foreign_key: 'visitor_id',
                                  dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification',
                                    foreign_key: 'visited_id',
                                    dependent: :destroy
                                  
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  has_many :meals,            dependent: :destroy
  has_many :exercise_records, dependent: :destroy
  has_one  :diet_goal,       dependent: :destroy
  has_many :weight_records,   dependent: :destroy
  has_one  :diary,            dependent: :destroy
  has_many :posts,            dependent: :destroy
  has_many :favorites,        dependent: :destroy
  has_many :post_comments,    dependent: :destroy
  has_many :items,            dependent: :destroy
  has_many :recipes,          dependent: :destroy
  has_many :my_sets,          dependent: :destroy

  validates :activated, inclusion: { in: [true, false] }

  #diaryが存在し利用停止状態になっている場合trueを返す
  def is_suspended_diary?
    if self.diary.present?
      !(self.diary.activated?)
    end
  end

  def follow(other_user)
    following << other_user
  end

  # ユーザーをフォロー解除する
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # 現在のユーザーがフォローしてたらtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end

  def daily_nutrients(date)
    daily_nutrients = { kcal: 0.0, protein: 0.0, carb: 0.0, fat: 0.0, df: 0.0 }

    meals = self.meals.where(date: date)

    meals.each do |meal|
      meal_nutrients = meal.total_nutrients

      daily_nutrients[:kcal]    += meal_nutrients[:kcal]
      daily_nutrients[:protein] += meal_nutrients[:protein]
      daily_nutrients[:carb]    += meal_nutrients[:carb]
      daily_nutrients[:fat]     += meal_nutrients[:fat]
      daily_nutrients[:df]      += meal_nutrients[:df]
    end

    if meals.present?
      return daily_nutrients
    else
      return false
    end
  end
end
