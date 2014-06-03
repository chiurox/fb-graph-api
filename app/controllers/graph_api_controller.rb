require 'uri'
require 'open-uri'
require 'json'
require 'time'
class GraphApiController < ApplicationController

  skip_before_action :verify_authenticity_token

  def index
  end

  def retrieved_posts

    # Parse search phrase and period from form parameters
    @search_phrase = URI.escape params[:phrase]
    @start_date = Date.strptime(params[:start_date], "%m/%d/%Y").to_time.to_i.to_s
    @end_date = Date.strptime(params[:end_date], "%m/%d/%Y").to_time.to_i.to_s
    @limit = params[:limit]

    # Use Koala Gem to get access token
    @oauth = Koala::Facebook::OAuth.new("442757099074908", "170c0265ec86615e855f9dd48f3c561e", "test")
    oauth_access_token = @oauth.get_user_info_from_cookies(cookies)["access_token"]

    # Facebook Graph Search Post is deprecated, but I managed to query it this way:
    # Also, location data isn't available when searching for posts, only if we're searching for Places
    uri = 'https://graph.facebook.com/v1.0/search?q=' + @search_phrase +
          '&type=post&fields=id,from,message,application,shares,likes,link,created_time'+
          '&with=location&limit=' + @limit + '&method=GET&format=json&suppress_http_code=1' +
          '&since=' + @start_date + '&until=' + @end_date + '&access_token=' + oauth_access_token
    response = JSON.parse(open(uri).read)
    @posts = response["data"]

    # Build an array to be used by Google Pie Chart displaying a breakdown of posts' category
    @ruby_category_data = Hash.new 0
    @posts.map { |fb_post| fb_post["from"]["category"] }.each do |category|
      @ruby_category_data[category] += 1 if !category.nil?
    end

    # The following would work with Facebook v2.0 using Facebook Query Language, but would only search your posts only
    #@graph = Koala::Facebook::API.new(oauth_access_token)
    #fql_query = "SELECT post_id, created_time, message FROM stream WHERE source_id = me() AND strpos(lower(message), lower('#{@search_phrase}')) >= 0"
    #@posts = @graph.fql_query(fql_query)

  end
end