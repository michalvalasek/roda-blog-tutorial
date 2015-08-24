class User < Sequel::Model

  attr_accessor :password, :password_confirmation

  def validate
    super
    validates_presence :password
    validates_length_range 4..40, :password
    validates_presence :password_confirmation
    errors.add(:password_confirmation, "must confirm password") if password != password_confirmation
  end

  def before_save
    super
    encrypt_password
  end

  private

  encrypt_password
    self.password_hash = BCrypt::Password.create(password)
  end
end
