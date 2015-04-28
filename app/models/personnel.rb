class Personnel < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  validates :auth_token, :email, uniqueness: true
  validates :first_name, :last_name, :first_name, :email, :encrypted_password, presence: true

  before_create :generate_auth_token!

  has_many :tasks, dependent: :destroy
  has_many :patients

  def generate_auth_token!
  	begin
  		self.auth_token = Devise.friendly_token
  	end while self.class.exists?(auth_token: auth_token)
  end

  def name
    self.first_name + ' ' + self.last_name
  end

end
