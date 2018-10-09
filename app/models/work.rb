class Work < ApplicationRecord
  validates :title, presence: true
  validates_inclusion_of :category, :in => %w( movie book album )
end
