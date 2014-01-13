require 'faraday'
require 'json'

module ArticleFeed
  class Feed
    attr_reader :data_store

    def initialize(input_data_store = nil)
      @data_store = (input_data_store || ArticleStore).new
    end

    def first_article
      data_store.first
    end
  end

  class Article
    attr_reader :title, :id, :data_source

    def initialize(input, input_data_source)
      @title = input["title"]
      @id    = input["id"]
      @data_source = input_data_source
    end

    def word_count
      body.split(" ").count
    end

    def body
      data_source.body_for(id)
    end
  end

  class ArticleStore
    attr_reader :data_source

    def initialize(input_data_source = ArticleDataSource)
      @data_source = input_data_source.new
    end

    def first
      data = fetch_data("articles")
      Article.new(data.first, self)
    end

    def body_for(id)
      data = fetch_data("articles/#{id}")
      body = data["article"]["body"]
    end

    def fetch_data(path)
      data_source.fetch( path )      
    end
  end

  class ArticleDataSource
    def fetch(path)
      JSON.parse( Faraday.get(url_root + path + extension).body )
    end

    def url_root
      "http://localhost:3000/api/v1/"
    end

    def extension
      ".json"
    end
  end
end
