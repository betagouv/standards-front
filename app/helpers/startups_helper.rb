module StartupsHelper
  def startup_audit_badge_content(startup)
    if startup.audit.blank?
      [ :new, "À faire" ]
    elsif startup.audit.complete?
      [ :success, "Complet" ]
    else
      [ :info, "En cours" ]
    end
  end

  def startup_audit_badge(startup)
    type, message = startup_audit_badge_content(startup)

    dsfr_badge(status: type) { message }
  end
end
