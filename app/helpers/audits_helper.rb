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

  def task_list_status(question)
    content_tag(:span, class: "fr-task-list__status") do
      if question.complete?
        content_tag(:span, class: [ "fr-badge fr-badge--sm fr-badge--success" ]) { "Terminé" }
      else
        content_tag(:span, class: [ "fr-badge fr-badge--sm" ]) { "À faire" }
      end
    end
  end
end
