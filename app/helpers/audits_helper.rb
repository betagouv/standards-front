module AuditsHelper
  STANDARDS_REPO = "https://github.com/betagouv/standards".freeze

  def task_list_status(question)
    content_tag(:span, class: "fr-task-list__status") do
      if question.complete?
        content_tag(:span, class: [ "fr-badge fr-badge--sm fr-badge--success" ]) { "Terminé" }
      elsif question.partially_complete?
        content_tag(:span, class: [ "fr-badge fr-badge--sm fr-badge--info" ]) { "Partiellement" }
      elsif question.all_nos?
        content_tag(:span, class: [ "fr-badge fr-badge--sm fr-badge--error" ]) { "Pas encore" }
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
    pc        = (completed.to_f / total) * 100

    safe_join([
      content_tag(:strong) { "#{completed}/#{total}" % [ completed, total ] },
      " standards validés (#{pc.to_i}%)"
    ])
  end

  def standard_feedback_link(question)
    path = "#{question.category}/#{question.id}"

    URI("#{STANDARDS_REPO}/issues/new").tap do |endpoint|
      endpoint.query = URI.encode_www_form(
        labels: "feedback",
        title: t("feedback.title", title: question.title.truncate(42)),
        body: t(
          "feedback.body",
          title: question.title,
          path: path,
          link: "#{STANDARDS_REPO}/blob/main/#{path}.md"
        )
      )
    end.to_s
  end
end
