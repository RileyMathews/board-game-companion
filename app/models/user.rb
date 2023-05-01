class User < ApplicationRecord
  has_many :games, dependent: :destroy, foreign_key: :created_by_id, inverse_of: false
  has_many :user_rooms, dependent: :destroy
  has_many :rooms, through: :user_rooms
  has_many :room_resources, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates :username, length: { maximum: 60 }
end
