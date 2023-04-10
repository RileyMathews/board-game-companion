class Face < ApplicationRecord
  belongs_to :die
  has_many :roll_results, dependent: :destroy
end
