class Subreddit < ActiveRecord::Base

  has_many :backgrounds

  def to_param
    self.name
  end

  def file_name
    string = self.backgrounds.map(&:id).join(',')
  end

  def ids_for_filename
  end

end
