module PollsHelper

  def normalize(params)
    if params.kind_of?(String)
      params.split
    else
      params.delete('')
      params
    end
  end
end
