# frozen_string_literal: true

class EvaluationUpgrader
  attr_reader :evaluation, :new_standards_yml

  def initialize(evaluation, new_standards_yml)
    @evaluation = evaluation
    @new_evaluation = Evaluation.new.initialize_with(new_standards_yml)
  end

  def changes
    {
      added: added_standards,
      deleted: deleted_standards,
      changed: changed_standards
    }.compact_blank
  end

  def saved_criteria_percentage
    all_criteria = new_standards.flat_map(&:criteria).map(&:label)

    answered_criteria = old_standards.flat_map(&:criteria).select(&:answered?).map(&:label)

    lost_count = answered_criteria
                   .reject { |c| all_criteria.include?(c) }
                   .size

    100 - lost_count
  end

  def apply!
    @new_evaluation.questions.each do |standard|
      # we update all standards except added and deleted which are
      # non-reconciliable updates
      unless standard.in?(changes.slice(:added, :deleted).values.flatten)
        previously = @evaluation.questions.find { |q| q == standard }

        standard.criteria.each do |criteria|
          criteria.answer = previously
                              .criteria
                              .find { |c| c.label == criteria.label }
                              &.answer
        end
      end
    end

    @evaluation.version = @new_evaluation.version
    @evaluation.questions = @new_evaluation.questions

    @evaluation.save!
  end

  def new_standards
    @new_evaluation.questions
  end

  def old_standards
    @evaluation.questions
  end

  def to_version
    @new_evaluation.version
  end

  private

  def added_standards
    new_standards - old_standards
  end

  def deleted_standards
    old_standards - new_standards
  end

  def identical_standards
    old_standards & new_standards
  end

  # changed standards only have updated criteria: they're seemingly
  # identical but we need to check further
  def changed_standards
    identical_standards.select do |standard|
      criteria_labels(old_standards, standard) != criteria_labels(new_standards, standard)
    end
  end

  def criteria_labels(standards, question)
    standards
      .find { |q| q == question }
      .criteria
      .map(&:label)
  end
end
