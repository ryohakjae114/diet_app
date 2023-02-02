class Diary < ApplicationRecord
  belongs_to :user

  validates :introduction, presence: true, length: { maximum: 200 }
  validates :public_diary, inclusion: [true, false]
  validates :public_body,  inclusion: [true, false]
end
