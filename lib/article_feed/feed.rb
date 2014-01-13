require 'faraday'
require 'json'

module ArticleFeed
  class Feed
    def first_article
      response = Faraday.get("http://localhost:3000/api/v1/articles.json").body
      data = JSON.parse(response)
      Article.new(data.first)
    end
  end

  class Article
    attr_reader :title, :id

    def initialize(input)
      @title = input["title"]
      @id    = input["id"]
    end

    def word_count
      response = Faraday.get("http://localhost:3000/api/v1/articles/#{id}.json").body
      data = JSON.parse(response)
      body = data["article"]["body"]
      body.split(" ").count
    end
  end
end
