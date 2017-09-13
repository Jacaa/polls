module PollsHelper

  def normalize(params)
    if params.kind_of?(String)
      new_params = []
      new_params << params
      new_params.delete('')
      return new_params
    else
      params.delete('')
      params
    end
  end

  def all_votes_for(poll)
    total = 0
    poll.answers_with_values.values.each { |v| total += v }
    total
  end

  def count_percentages(poll)
    percentages = {}
    number_of_votes = all_votes_for poll
    poll.answers_with_values.each do |answer, value|
      if number_of_votes == 0
        percentages[answer] = 0
      else
        percentages[answer] = (value * 100.0 / number_of_votes).round(2)
      end
    end
    return percentages
  end
end
