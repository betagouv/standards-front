module HomeHelper
  COLUMN_DEFAULTS = {
    "sm" => 12,
    "md" => 8,
    "lg" => 6
   }

  def standard_url(standard)
    "https://github.com/betagouv/standards/blob/main/#{standard.category}/#{standard.id}.md"
  end

  def default_column_classes
    COLUMN_DEFAULTS
      .merge(column_overrides)
      .map { |size, cols| "fr-col-#{size}-#{cols}" }
  end

  private

  def column_overrides
    overrides = content_for(:column_overrides)

    return {} if !overrides

    overrides
      .split(",")
      .map(&:strip)
      .map { |pair| pair.split(": ").map(&:strip) }
      .to_h
  end
end
