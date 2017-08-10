class Article < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :article_categories
  has_many :categories, through: :article_categories
	validates :title, presence: true
  validates :link, presence: true

  def category_name=(name)
    self.categories << Category.find_or_create_by(name: name)
  end

  def category_name
    
  end

end
