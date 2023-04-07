class Die < ApplicationRecord
  belongs_to :game
  has_many :faces, dependent: :destroy

  def roll(number: 1)
    potential_results = []
    faces.each do |face|
      face.count.times do
        potential_results.push(face)
      end
    end
    Array.new(number.to_i).map do
      potential_results.sample
    end
  end
end
