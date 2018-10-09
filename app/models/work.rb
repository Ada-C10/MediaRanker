class Work < ApplicationRecord
  validates :title, presence: true, uniqueness: { scope: :category, message: "this work was already added for this category" }
  validates_inclusion_of :category, :in => %w( movie book album )
end
