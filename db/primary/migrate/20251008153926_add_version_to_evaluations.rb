class AddVersionToEvaluations < ActiveRecord::Migration[8.0]
  def up
    add_column :evaluations, :version, :string

    Evaluation.update_all(version: "N/A")

    change_column_null :evaluations, :version, false
  end

  def down
    remove_column :evaluations, :version
  end
end
