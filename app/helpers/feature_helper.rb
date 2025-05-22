# This tiny helper gathers feature-flag-looking ENV variables
# (BETA_STANDARDS_ENABLES_<NAME>) and will subsequently answer
# `has_enabled_feature?(:name)`.

# No value coercion is performed, which means
# `BETA_STANDARDS_ENABLES_FOO=false` will make
# `is_feature_enabled?(:foo)` return true, whereas
# `BETA_STANDARDS_ENABLES_FOO=` will consider it disabled, because
# shoving your programming language beyond empty strings in a shell
# environment is the kingdom of fools.
module FeatureHelper
  def has_enabled_feature?(name)
    enabled_features[name].present?
  end

  def has_disabled_feature?(name)
    !has_enabled_feature?(name)
  end

  def enabled_features
    @features ||= discover_features!
  end

  private

  def discover_features!
    ENV
      .select { |k, _v| k.include?("BETA_STANDARDS_ENABLES_") }
      .map do |k, v|
      name = k
               .split("BETA_STANDARDS_ENABLES_")
               .last
               .downcase
               .to_sym

      [ name, v ]
    end.to_h
  end
end
