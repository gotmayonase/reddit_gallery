class Subreddit < ActiveRecord::Base

  has_many :backgrounds

  def to_param
    self.name.gsub('porn','')
  end

end
