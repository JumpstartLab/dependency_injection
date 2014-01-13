gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/article_feed/feed'

class FeedTest < Minitest::Test
  def test_it_exists
    assert ArticleFeed::Feed
  end

  def test_it_finds_the_first_article
    expected_title = "Qui Ipsa Maiores Iusto Eligendi Aut 0"
    feed = ArticleFeed::Feed.new
    assert_equal expected_title, feed.first_article.title
  end

  def test_it_finds_the_first_article_word_count
    feed = ArticleFeed::Feed.new
    first_article = feed.first_article
    assert_equal 26, first_article.word_count
  end
end
