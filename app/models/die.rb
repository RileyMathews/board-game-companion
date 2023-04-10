class Die < ApplicationRecord
  belongs_to :game
  has_many :faces, dependent: :destroy

  def roll(roll_log:, number: 1)
    rolled_faces = rolled_faces number
    roll = roll_log.rolls.create!
    roll_results_data = rolled_faces.map { |face| { face_id: face.id, roll_id: roll.id } }
    RollResult.insert_all! roll_results_data # rubocop:disable Rails/SkipsModelValidations
  end

private

  def rolled_faces(number)
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
