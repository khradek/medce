require 'test_helper'

class EmailSubscribersControllerTest < ActionController::TestCase
  setup do
    @email_subscriber = email_subscribers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:email_subscribers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create email_subscriber" do
    assert_difference('EmailSubscriber.count') do
      post :create, email_subscriber: { email: @email_subscriber.email }
    end

    assert_redirected_to email_subscriber_path(assigns(:email_subscriber))
  end

  test "should show email_subscriber" do
    get :show, id: @email_subscriber
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @email_subscriber
    assert_response :success
  end

  test "should update email_subscriber" do
    patch :update, id: @email_subscriber, email_subscriber: { email: @email_subscriber.email }
    assert_redirected_to email_subscriber_path(assigns(:email_subscriber))
  end

  test "should destroy email_subscriber" do
    assert_difference('EmailSubscriber.count', -1) do
      delete :destroy, id: @email_subscriber
    end

    assert_redirected_to email_subscribers_path
  end
end
