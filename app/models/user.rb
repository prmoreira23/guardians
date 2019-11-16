class User < ApplicationRecord
  has_many :emergency_contacts

  validates :email, :token, presence: true
  validates :email, :token, uniqueness: true


  def initialize(params)
    super(params)
    set_token
  end

  private
  def set_token
    self.token = UUID.new.generate unless token
  end
end
