require 'test_helper'

class TanksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get tanks_index_url
    assert_response :success
  end

end
