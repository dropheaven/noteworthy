class Category < ActiveRecord::Base
  has_many :article_categories
  has_many :articles, through: :article_categories
	
	before_save { name.downcase! }
	validates :name, presence: true,
									 uniqueness: true
	
end
