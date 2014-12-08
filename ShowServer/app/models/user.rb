class User < ActiveRecord::Base
  has_and_belongs_to_many :shows

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  before_save :ensure_authentication_token

  def ensure_authentication_token
   if authentication_token.blank?
     self.authentication_token = generate_authentication_token
   end
  end

  def self.authenticate(email, password)
    user = User.find_for_authentication(email: email)
    return nil if user.nil?
    user.valid_password?(password) ? user : nil
  end

  private

  def generate_authentication_token
   loop do
     token = Devise.friendly_token
     break token unless User.where(authentication_token: token).first
   end
  end
end
