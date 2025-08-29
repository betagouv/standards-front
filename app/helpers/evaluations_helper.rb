module EvaluationsHelper
  STANDARDS_REPO = "https://github.com/betagouv/standards".freeze

  def category_progress_label(evaluation, category)
    questions = evaluation.questions_for(category)

    "(%s/%s)" % [ questions.count(&:complete?), questions.count ]
  end

  def progress_badge(progressable, size = "md")
    status, message = if progressable.unanswered?
                        [ :new, "À faire" ]
    elsif progressable.complete?
                        [ :success, "Complet" ]
    elsif progressable.all_nos?
                        [ :error, "Pas encore" ]
    elsif progressable.partially_complete?
                        [ :info, progressable.is_a?(Category) ? "En cours" : "Partiellement" ]
    end

    dsfr_badge(status: status, html_attributes: { class: "fr-badge--#{size}" }) { message }
  end

  def total_completion_label(evaluation)
    completed = evaluation.questions.count(&:complete?)
    total     = evaluation.questions.count
    pc        = (completed.to_f / total) * 100

    safe_join([
      content_tag(:strong) { "#{completed}/#{total}" % [ completed, total ] },
      " critères validés (#{pc.to_i}%)"
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
