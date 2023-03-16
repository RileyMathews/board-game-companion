class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  extend FriendlyId
  friendly_id :username, use: :slugged

  validates :username, length: { maximum: 60 }
end
