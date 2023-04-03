class RollLog < ApplicationRecord
  belongs_to :room
  belongs_to :user
  has_many :roll_results, dependent: :destroy

  def summary
    roll_results.where(archived: false).joins(:face).group("faces.name").count
  end
end
