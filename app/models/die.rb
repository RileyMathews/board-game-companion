class Die < ApplicationRecord
  belongs_to :game
  has_many :faces, dependent: :destroy

  def roll(number: 1)
    Array.new(number.to_i).map do
      faces.sample
    end
  end
end
