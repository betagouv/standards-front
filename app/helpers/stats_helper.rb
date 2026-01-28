module StatsHelper
  def total_evaluations(evaluations)
    evaluations.count
  end

  def total_completed_evaluations(evaluations)
    evaluations.count(&:complete?)
  end

  def average_completion_rate(evaluations)
    evaluations.map(&:completion_level).sum / evaluations.count.to_f
  end

  def average_completion_rate_per_category(evaluations)
    categories = Evaluation.from_latest_standards.categories
    results    = evaluations.map(&:completion_stats)

    categories.map do |category|
      [
        category,
        results.map { |evaluation| evaluation[category] || 0 }.sum / evaluations.count
      ]
    end.to_h
  end

  def average_conformity_rate_per_category(evaluations)
    categories = Evaluation.from_latest_standards.categories
    results    = evaluations.map(&:conformity_stats)

    categories.map do |category|
      [
        category,
        results.map { |evaluation| evaluation[category] || 0 }.sum / evaluations.count
      ]
    end.to_h
  end

  def completion_and_conformity_per_category_charts(evaluations)
    column_chart(
      [
        {
          name: "Taux moyen de complétion",
          data: average_completion_rate_per_category(evaluations)
        },
        {
          name: "Taux moyen de conformité",
          data: average_conformity_rate_per_category(@evaluations)
        }
      ],
      precision: 2,
      suffix: "%"
    )
  end
end
