class User < ApplicationRecord
  has_secure_password
  validates :username, presence: true, uniqueness: true
  has_many :video_shares, foreign_key: "owner_id"
end
