class CreateBackgrounds < ActiveRecord::Migration
  def change
    create_table :backgrounds do |t|
      t.string :reddit_id
      t.integer :score
      t.string :permalink
      t.text :title
      t.integer :width
      t.integer :height
      t.integer :num_comments
      t.string :url
      t.datetime :original_created_at
      t.string :author
      t.belongs_to :subreddit
      t.attachment :image

      t.timestamps
    end
  end
end
