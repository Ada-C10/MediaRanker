class Work < ApplicationRecord
  validates :title, presence: true
  validates_inclusion_of :categorycat, :in => %w( movie book album )
end
