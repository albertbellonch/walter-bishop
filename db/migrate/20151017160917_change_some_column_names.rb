class ChangeSomeColumnNames < ActiveRecord::Migration
  def change
    rename_column :episodes, :tv_series, :show
    rename_column :episodes, :start_time, :starts_at
    rename_column :episodes, :end_time, :ends_at
  end
end
