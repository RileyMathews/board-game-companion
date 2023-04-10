class RollLog < ApplicationRecord
  belongs_to :user_room
  has_many :rolls, dependent: :destroy

  def summary
    RollResult.joins(:face).joins(:roll).where(archived: false, roll: { roll_log: self }).group("faces.name").count
  end
end
