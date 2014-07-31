class AddInvalidImageToBackgrounds < ActiveRecord::Migration
  def change
    add_column :backgrounds, :invalid_image, :boolean
  end
end
