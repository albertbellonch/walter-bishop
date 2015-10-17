class AddStatusToEpisodes < ActiveRecord::Migration
  def change
    add_column :episodes, :status, :string
  end
end
