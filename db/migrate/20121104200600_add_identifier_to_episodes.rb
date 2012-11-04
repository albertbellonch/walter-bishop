class AddIdentifierToEpisodes < ActiveRecord::Migration
  def change
    add_column :episodes, :identifier, :string
  end
end
