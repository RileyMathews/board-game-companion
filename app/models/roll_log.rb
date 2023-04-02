class RollLog < ApplicationRecord
  belongs_to :room
  belongs_to :user
  has_many :roll_results, dependent: :destroy

  def summary
    RollResult.where(archived: false).joins(:face).group('faces.name').count
  end
end
