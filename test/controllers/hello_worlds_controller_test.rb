require "test_helper"

class HelloWorldsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get hello_worlds_index_url
    assert_response :success
  end

  test "should get show" do
    get hello_worlds_show_url
    assert_response :success
  end

  test "should get new" do
    get hello_worlds_new_url
    assert_response :success
  end

  test "should get edit" do
    get hello_worlds_edit_url
    assert_response :success
  end

  test "should get create" do
    get hello_worlds_create_url
    assert_response :success
  end

  test "should get update" do
    get hello_worlds_update_url
    assert_response :success
  end

  test "should get destroy" do
    get hello_worlds_destroy_url
    assert_response :success
  end
end
