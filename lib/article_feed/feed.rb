require 'faraday'
require 'json'

module ArticleFeed
  class Feed
    def first_article
      ArticleStore.new.first
    end
  end

  class Article
    attr_reader :title, :id

    def initialize(input)
      @title = input["title"]
      @id    = input["id"]
    end

    def word_count
      body.split(" ").count
    end

    def body
      ArticleStore.new.body_for(id)
    end
  end

  class ArticleStore
    def url_root
      "http://localhost:3000/api/v1/"
    end

    def extension
      ".json"
    end

    def first
      data = fetch_data("articles")
      Article.new(data.first)
    end

    def body_for(id)
      data = fetch_data("articles/#{id}")
      body = data["article"]["body"]
    end

    def fetch_data(path)
      JSON.parse( Faraday.get(url_root + path + extension).body )
    end
  end
end
