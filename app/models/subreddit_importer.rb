require 'open-uri'
class SubredditImporter
  include HTTParty
  base_uri "www.reddit.com"
  format :json

  attr_accessor :subreddit, :retries

  def initialize(subreddit)
    self.subreddit = subreddit
    self.retries = 0
  end

  def self.import(subreddit)
    importer = self.new(subreddit)
    importer.import
  end

  def import
    begin
      response = self.class.get("/r/#{subreddit.name}/top.json", { query: { t: 'all', limit: '100' } })
    rescue => e
      retries += 1
      if retries >= 3
        raise e
      else
        import
      end
    end
    puts "Importing #{subreddit.name}: #{response.request.uri}"
    links = response.parsed_response["data"]["children"]

    links.each do |link|
      data = link["data"]
      title = data["title"]
      next unless title =~ /(\d{3,5})\s?x\s?(\d{3,5})/
      unless Background.find_by(reddit_id: data["id"])
        image = open(data["url"]) rescue next
        next if image.content_type == 'image/gif'
        b = Background.new(
          subreddit_id: subreddit.id,
          reddit_id: data["id"],
          score: data["score"],
          permalink: data["permalink"],
          title: data["title"],
          width: $1,
          height: $2,
          num_comments: data["num_comments"],
          url: data["url"],
          original_created_at: Time.at(data["created_utc"]),
          author: data["author"]
        )
        if image.content_type =~ /image/
          b.image = image
          b.save
          print 'i'
        else
          b.invalid_image = true
          b.save
          print 'v'
        end
      else
        print '.'
      end
    end
    puts
  end

end
