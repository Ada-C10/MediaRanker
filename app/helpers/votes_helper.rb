module VotesHelper

  def get_error_message(vote)
    error_msg = ""
    vote.errors.messages.each do |field, problem_list|
      problem_list.each do |problem|
        error_msg << problem
      end
    end

    return error_msg
  end

end
