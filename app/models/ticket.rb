class Ticket < ApplicationRecord
  belongs_to :poll
  has_one :group, through: :poll 
	has_many :candidates
  has_one_attached :portrait
end
