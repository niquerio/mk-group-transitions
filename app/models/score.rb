class Score < ApplicationRecord
  belongs_to :candidate
  belongs_to :ballot
end
