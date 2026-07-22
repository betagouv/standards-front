module EvaluationsHelper
  STANDARDS_REPO = "https://github.com/betagouv/standards".freeze

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
      " standards renseignés (#{pc.to_i}%)"
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

  def upgrade_badge_for(key)
    case key
    when :added
      :new
    when :deleted
      :error
    when :changed
      :info
    end
  end

  def badge_type_for_level(level)
    case level
    when 0..10
      :error
    when 10..50
      :new
    when 50..75
      :info
    when 75..100
      :success
    end
  end

  def badge_for_answer(answer)
    label = Evaluation::Criterion::ANSWERS[answer] || "non renseigné"

    type = case answer
    when "yes"
      :success
    when "no"
      :error
    when "na"
      :info
    when nil
      nil
    end

    dsfr_badge(status: type, html_attributes: { class: "fr-badge--no-icon fr-badge--sm" }) { label }
  end
end
