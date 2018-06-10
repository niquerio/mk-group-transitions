class Ballot < ApplicationRecord
  belongs_to :poll
  has_many :scores
  accepts_nested_attributes_for :scores
end
