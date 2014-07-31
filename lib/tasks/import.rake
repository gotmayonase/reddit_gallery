task :import => :environment do
  Subreddit.all.order('name asc').each do |subreddit|
    SubredditImporter.import(subreddit)
  end
end
