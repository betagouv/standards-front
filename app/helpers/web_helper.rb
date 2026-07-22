module WebHelper
  def boldify_if_positive(number)
    if number.positive?
      content_tag(:strong, number)
    else
      number
    end
  end
end
