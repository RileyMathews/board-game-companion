class Game < ApplicationRecord
  extend FriendlyId
  belongs_to :created_by, class_name: "User"
  has_many :rooms, dependent: :destroy
  has_many :dice, dependent: :destroy, class_name: "Die"
  friendly_id :name, use: :slugged

  validates :name, uniqueness: true, presence: true

  scope :ordered, -> { order(id: :desc) }

  def should_generate_new_friendly_id?
    name_changed?
  end
end
