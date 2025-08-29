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
end
