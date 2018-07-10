class Zipcode < ApplicationRecord
	has_and_belongs_to_many :groups

  def to_s
    self.number.to_s
  end
end
