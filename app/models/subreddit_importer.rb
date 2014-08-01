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
      self.retries += 1
      if self.retries >= 3
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
      regex = /[\[\(](\d{3,5})\s?x\s?(\d{3,5})[\]\)]/
      next unless title =~ regex
      title.gsub!(regex,'')
      unless Background.unscoped.find_by(reddit_id: data["id"])
        b = Background.new(
          subreddit_id: subreddit.id,
          reddit_id: data["id"],
          score: data["score"],
          permalink: data["permalink"],
          title: title,
          width: $1,
          height: $2,
          num_comments: data["num_comments"],
          url: data["url"],
          original_created_at: Time.at(data["created_utc"]),
          author: data["author"]
        )
        begin
          b.image = URI.parse(data["url"])
          if b.image.content_type == 'image/gif'
            b.image = nil
            b.invalid_image = true
            b.save
            pink_print 'g'
          else
            if b.save
              green_print 'i'
            else
              b.image = nil
              b.invalid_image = true
              b.save
              yellow_print 'v'
            end
          end
        rescue => e
          b.invalid_image = true
          b.save
          red_print 'e'
        end
      else
        print '.'
      end
    end
    puts
  end

  def red_print(string)
    print colorize(string, 31)
  end

  def green_print(string)
    print colorize(string, 32)
  end

  def yellow_print(string)
    print colorize(string, 33)
  end

  def pink_print(string)
    print colorize(string, 35)
  end

  def colorize(string, code)
    "\e[#{code}m#{string}\e[0m"
  end

end
