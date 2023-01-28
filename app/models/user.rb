# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  enum gender: { male: 0, female: 1 }

  has_many :meals, dependent: :destroy
  has_many :weight_records, dependent: :destroy
  has_one  :diary         , dependent: :destroy
  has_many :posts
  has_many :items
  has_many :recipes
  has_many :my_sets

  validates :activated, inclusion: { in: [true, false] }

  #diaryが存在し利用停止状態になっている場合trueを返す
  def is_suspended_diary?
    if self.diary.present?
      !(self.diary.activated?)
    end
  end
end
