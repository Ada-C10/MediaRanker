class ApplicationRecord < ActiveRecord::Base
  VALID_CATEGORIES = %w(album book movie)
  self.abstract_class = true
end
