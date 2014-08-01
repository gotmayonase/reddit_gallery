class ChangeUrlToTextType < ActiveRecord::Migration
  def up
    change_column :backgrounds, :url, :text
  end

  def down
    change_column :backgrounds, :url, :string
  end
end
