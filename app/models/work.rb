class Work < ApplicationRecord
  has_many :votes
  has_many :users, through: :votes

  def upvote user
    @vote = Vote.new
    @vote.work_id = self.id
    @vote.user_id = user.id
    @vote.vote_time = Date.today
    unless @vote.valid?
      puts "*" * 80
      puts "#{@vote.errors.messages}"
    end
    @vote.save
  end

  def self.sorted(category)
    works = Work.all.where(category: category).to_a
    return works.sort_by { |work| work.total_votes }
  end

  def self.top_10(category)
    return Work.sorted_list(category)[0..9]
  end

  def self.top
    works = Work.all.to_a
    return works.max_by { |work| work.total_votes }
  end
end
