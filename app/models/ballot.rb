class Ballot < ApplicationRecord
  belongs_to :poll
  has_many :scores
  accepts_nested_attributes_for :scores

  after_initialize :init

  def init
    self.sca_name ||= ''
    self.modern_name ||= ''
    self.comment ||= ''
  end
end
