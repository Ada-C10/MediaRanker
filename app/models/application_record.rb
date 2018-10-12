class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  #application-wide method to format dates
  def self.format_date(given_date)
    return given_date.strftime("%B %d, %Y")
  end

end
