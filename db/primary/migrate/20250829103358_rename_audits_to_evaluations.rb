class RenameAuditsToEvaluations < ActiveRecord::Migration[8.0]
  def change
    rename_table :audits, :evaluations
  end
end
