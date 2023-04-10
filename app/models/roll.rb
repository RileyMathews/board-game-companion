class Roll < ApplicationRecord
  belongs_to :roll_log
  has_many :roll_results, dependent: :destroy

  def summary
    roll_results.joins(:face).group("faces.name").count
  end

  def summary_string
    summary_map = summary
    summary_map.map { |face, count| "#{face}: #{count}" }.join(" | ")
  end
end
