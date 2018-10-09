class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work

  def created_at
    attributes['created_at'].strftime("%B, %d, %Y")
  end
end
