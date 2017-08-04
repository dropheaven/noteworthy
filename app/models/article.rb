class Article < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :article_categories
  has_many :categories, through: :article_categories
	
	validates :title, presence: true
	
	def category_name=(name)
		self.categories.build(name: name)
	end
	
	def category_name
		self.categories.map(&:content)
	end
end
