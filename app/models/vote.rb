class Vote < ApplicationRecord
  belongs_to :work
  belongs_to :user

  validates :quantity, numericality: { only_integer: true, greater_than: 0 }
end
