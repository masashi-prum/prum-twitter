require "test_helper"

class TweetsInterfaceTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
    log_in_as(@user)
  end
end

class tweetsInterfaceTest < tweetsInterface

  test "should paginate tweets" do
    get root_path
    assert_select 'div.pagination'
  end

  test "should show errors but not create tweet on invalid submission" do
    assert_no_difference 'tweet.count' do
      post tweets_path, params: { tweet: { content: "" } }
    end
    assert_select 'div#error_explanation'
    assert_select 'a[href=?]', '/?page=2'  # 正しいページネーションリンク
  end

  test "should create a tweet on valid submission" do
    content = "This tweet really ties the room together"
    assert_difference 'tweet.count', 1 do
      post tweets_path, params: { tweet: { content: content } }
    end
    assert_redirected_to root_url
    follow_redirect!
    assert_match content, response.body
  end

  test "should have tweet delete links on own profile page" do
    get users_path(@user)
    assert_select 'a', text: 'delete'
  end

  test "should be able to delete own tweet" do
    first_tweet = @user.tweets.paginate(page: 1).first
    assert_difference 'tweet.count', -1 do
      delete tweet_path(first_tweet)
    end
  end

  test "should not have delete links on other user's profile page" do
    get user_path(users(:archer))
    assert_select 'a', { text: 'delete', count: 0 }
  end
end
