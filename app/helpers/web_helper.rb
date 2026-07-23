module WebHelper
  def boldify_if_positive(number)
    if number.positive?
      content_tag(:strong, number)
    else
      number
    end
  end

  def user_contact_link(user)
    if user.present?
      name_and_email_link(user.fullname, user.primary_email || user.secondary_email)
    end
  end

  def name_and_email_link(name, email)
    if email.blank?
      name
    else
      mail_to email, "#{name} <#{email}>"
    end
  end

  def release_link(version)
    url = "https://github.com/betagouv/standards/releases/tag/"

    if version.nil? || version == "N/A"
      "N/A (obsolète)"
    else
      link_to version, url + version
    end
  end
end
