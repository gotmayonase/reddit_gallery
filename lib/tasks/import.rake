task :import => :environment do
  Subreddit.all.each do |subreddit|
    SubredditImporter.import(subreddit)
  end
end
