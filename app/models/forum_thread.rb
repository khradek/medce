class ForumThread < ApplicationRecord
  
  belongs_to :user
  has_many :forum_posts
  has_many :users, through: :forum_posts

  accepts_nested_attributes_for :forum_posts

  validates :category, presence: true
  validates :subject, presence: true
  validates_associated :forum_posts



end
