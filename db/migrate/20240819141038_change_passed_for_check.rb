class ChangePassedForCheck < ActiveRecord::Migration[7.1]
  def change
    change_column :repository_checks, :passed, :boolean, default: nil, null: true
  end
end
