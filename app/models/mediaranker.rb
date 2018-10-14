class Mediaranker < ApplicationRecord
  def self.spotlight
    work = Work.all.max_by {|work| work.votes.count}
  end
end
