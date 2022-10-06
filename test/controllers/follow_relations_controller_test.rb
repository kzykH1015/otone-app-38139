require 'test_helper'

class FollowRelationsControllerTest < ActionDispatch::IntegrationTest
  test 'should get followings' do
    get follow_relations_followings_url
    assert_response :success
  end

  test 'should get followers' do
    get follow_relations_followers_url
    assert_response :success
  end
end
