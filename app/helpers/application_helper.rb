module ApplicationHelper
  def current_user?
    current_user.present?
  end

  def current_path?(path)
    # the root path ("/") sits above all the other paths so when we're
    # comparing against it, make sure we're exactly on it otherwise it
    # matches along with the others ("/startups" does start with "/").
    if path == "/"
      request.path == path
    else
      request.path.start_with?(path)
    end
  end

  def add_current_attribute(path)
    if current_path?(path)
      { html_attributes: { "aria-current" => "page" } }
    else
      nil
    end
  end
end
