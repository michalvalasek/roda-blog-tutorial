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

  def self.authenticate(email, password)
    user = filter(Sequel.function(:lower, :email) => Sequel.function(:lower,email)).first
    user && user.has_password?(password) ? user : nil
  end

  def has_password?(password)
    BCrypt::Password.new(self.password_hash) == password
  end

  private

  def encrypt_password
    self.password_hash = BCrypt::Password.create(password)
  end
end
