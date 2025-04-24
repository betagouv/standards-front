module AuditsHelper
  COMPLETE_KEY = {
    true: :completed,
    false: :incomplete
  }

  def progress_for_category(audit, category)
    questions = audit.questions_for(category)

    questions
      .map(&:complete?)
      .tally({})
      .transform_keys { |key| COMPLETE_KEY[key.to_s.to_sym] }
      .merge({ total: questions.count })
  end
end
