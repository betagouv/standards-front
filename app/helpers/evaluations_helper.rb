module EvaluationsHelper
  STANDARDS_REPO = "https://github.com/betagouv/standards".freeze

  def category_progress_label(evaluation, category)
    questions = evaluation.standards_for(category)

    "(%s/%s)" % [ questions.count(&:complete?), questions.count ]
  end

  def progress_badge(progressable, size = "md")
    status, message =
      if progressable.conform?
        [ :success, "Validé" ]
      elsif progressable.complete?
        [ :info, "Complété" ]
      else
        [ :new, "À compléter" ]
      end

    dsfr_badge(status: status, html_attributes: { class: "fr-badge--#{size}" }) { message }
  end

  def total_completion_label(evaluation)
    completed = evaluation.questions.count(&:complete?)
    total     = evaluation.questions.count
    pc        = (completed.to_f / total) * 100

    safe_join([
      content_tag(:strong) { "#{completed}/#{total}" % [ completed, total ] },
      " critères renseignés (#{pc.to_i}%)"
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

  def version_release_link(version)
    File.join(STANDARDS_REPO, "releases/tag/", version).to_s
  end
end
