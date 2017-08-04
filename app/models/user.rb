class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :articles
  has_many :comments

  before_save { email.downcase! }
  before_save { username.downcase! }
  validates :username, presence: true, length: { within: 2..20 },
                       uniqueness: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 30 },
                    format: {with: VALID_EMAIL_REGEX },
                    uniqueness: true

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.username = auth.info.name
      user.password = Devise.friendly_token[0,20]
    end
  end
	
	def self.search(username)
		if username
			username.downcase!
			self.find_by(username: username)
		end
	end
end
