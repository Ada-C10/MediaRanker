module PagesHelper
  def first_ten_by_votes(collection)
    sorted = collection.sort_by { |medium| medium.votes.length }
    sorted.reverse!
    return sorted.first(10)
  end

  def media_spotlight_text(medium)
    text = "#{medium.votes.length} "

    medium.votes.length == 1 ? text += "vote" : text += "votes"

    return text += " - #{medium.description}"
  end
end
