class User < ApplicationRecord
  validates :email, :token, presence: true, uniqueness: true
  has_many: :emergency_contacts

  def initialize(params)
    super(params)
    set_token
  end

  private
  def set_token
    self.token = UUID.new.generate unless token
  end
end
