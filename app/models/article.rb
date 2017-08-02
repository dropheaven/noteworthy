class Article < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :article_categories
  has_many :categories, through: :article_categories
end
