module MediaHelper
  def order_by_votes(collection)
    sorted = collection.sort_by { |medium| medium.votes.length }
    return sorted.reverse!
  end
end
