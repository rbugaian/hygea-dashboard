class Doctor < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  validates :auth_token, uniqueness: true

  before_create :generate_auth_token!

  has_many :tasks, dependent: :destroy
  has_many :patients
  

  def name
    self.first_name + ' ' + self.last_name
  end

  def generate_auth_token!
    begin
      self.auth_token = Devise.friendly_token
    end while self.class.exists?(auth_token: auth_token)
  end

end
