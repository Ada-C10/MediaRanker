module MediaHelper
  def order_by_votes(collection)
    sorted = collection.sort_by { |medium| medium.votes.length }
    return sorted.reverse!
  end

  def parse_bro_category(category)
    case category
    when "album"
      return "Sound"
    when "movie"
      return "Visual"
    when "book"
      return "Word"
    end
  end
end
