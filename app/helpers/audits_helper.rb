module AuditsHelper
  COMPLETE_KEY = {
    true: :completed,
    false: :incomplete
  }

  def task_list_status(question)
    content_tag(:span, class: "fr-task-list__status") do
      if question.complete?
        content_tag(:span, class: [ "fr-badge fr-badge--sm fr-badge--success" ]) { "Terminé" }
      else
        content_tag(:span, class: [ "fr-badge fr-badge--sm" ]) { "À faire" }
      end
    end
  end

  def category_progress_label(audit, category)
    questions = audit.questions_for(category)

    "(%s/%s)" % [ questions.count(&:complete?), questions.count ]
  end

  def category_progress_badge(audit, category)
    case audit.completion_stats[category]
    when 0
      content_tag(:span, class: "fr-badge") { "À faire" }
    when 100
      content_tag(:span, class: "fr-badge fr-badge--success") { "Complet" }
    else
      content_tag(:span, class: "fr-badge fr-badge--info") { "En cours" }
    end
  end

  def total_completion_label(audit)
    completed = audit.questions.count(&:complete?)
    total     = audit.questions.count
    pc        = completed / total

    safe_join([
      content_tag(:strong) { "#{completed}/#{total}" % [ completed, total ] },
      " standards validés (#{pc}%)"
    ])
  end
end
