class Post < ApplicationRecord
  has_many :comments, dependent: :destroy
  belongs_to :user, dependent: :destroy
  self.per_page = 2
  validates :title, presence: true, length: { maximum: 50 }
  validates :body, presence: true
end
