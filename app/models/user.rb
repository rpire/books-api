class User < ApplicationRecord
  devise :database_authenticatable,
         :registerable,
         :jwt_authenticatable,
         jwt_revocation_strategy: JwtDenylist

  has_many :books, dependent: :destroy

  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true
  validates :password, presence: true, length: { minimum: 8 }
  validates :bio, length: { maximum: 250 }
  validates :icon, presence: true,
                   numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 9 }
end
