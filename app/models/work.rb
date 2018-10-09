class Work < ApplicationRecord
  has_many :votes

  # validations goes here: user and work combo is unique...



  def self.top_ten(category)
    return Work.where(category: category)
  end




end
