class User < ApplicationRecord
  attr_reader :token

  before_save :set_token
  validates :email, presence: true, uniqueness: true

  private
  def set_token
    self.token = UUID.new.generate unless token
  end
end
