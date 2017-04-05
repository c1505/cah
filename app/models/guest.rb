class Guest < User
  validates_presence_of   :email, if: :email_required?
  validates_presence_of   :password, if: :email_required?
  
  protected
  
  def email_required?
    false
  end
  
  def password_required?
    false
  end
end