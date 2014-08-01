class Background < ActiveRecord::Base

  default_scope -> { order('score desc').where('image_file_name is not null') }

  belongs_to :subreddit

  has_attached_file :image, :styles => { :medium => "300x300#", :thumb => "100x100>" }
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  def file_extension
    {
      'image/jpeg' => 'jpg',
      'image/png' => 'png',
      'image/gif' => 'gif'
    }[self.image.content_type]
  end

end
