class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true, length: { maximum: 25 }
  validates :email, presence: true, length: { maximum: 60 }, uniqueness: true

  has_many :tasks
end
