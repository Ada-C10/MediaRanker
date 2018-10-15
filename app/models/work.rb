class Work < ApplicationRecord
  has_many :votes
  has_many :users, through: :votes

  def upvote
    @vote = Vote.new
    @vote.work_id = params[:id]
    @vote.user_id = session[:user]
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
