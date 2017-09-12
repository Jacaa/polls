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
end
