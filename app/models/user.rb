class User < ApplicationRecord
  has_many :votes

  def media_votes
    combined_works = []

    self.votes.each do |vote|
      work = Work.find_by(id: vote.work_id)

      combined_works << work
    end

    return combined_works
  end

end
