class CreateEpisodes < ActiveRecord::Migration
  def change
    create_table :episodes do |t|
      t.string :tv_series
      t.string :title
      t.integer :season
      t.integer :number
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
