module StartupsHelper
  def startup_evaluation_badge_content(startup)
    if startup.evaluation.blank?
      [ :new, "À faire" ]
    elsif startup.evaluation.complete?
      [ :success, "Complet" ]
    else
      [ :info, "En cours" ]
    end
  end

  def startup_evaluation_badge(startup)
    type, message = startup_evaluation_badge_content(startup)

    dsfr_badge(status: type) { message }
  end

  def startup_sponsor_acronym_list(startup)
    startup.organizations.map do |org|
      content_tag(:abbr, org.acronym, title: org.name)
    end.join(", ").html_safe
  end
end
