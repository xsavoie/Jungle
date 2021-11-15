class User < ActiveRecord::Base

  has_secure_password

  def authenticate_with_credentials(email, password)
    email = email.downcase.strip
    @user = User.find_by(email: email)
    if @user && @user.authenticate(password)
      return @user
    else 
      return nil
    end
  end

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }
  validates :password_confirmation, length: { minimum: 6 }


end
