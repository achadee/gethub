require 'test_helper'

class ReposControllerTest < ActionDispatch::IntegrationTest

  # test basic end to end 200 response
  #
  test "get repos" do
    get '/repos'
    assert_response :success
  end
end
