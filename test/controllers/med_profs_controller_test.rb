require 'test_helper'

class MedProfsControllerTest < ActionController::TestCase
  setup do
    @med_prof = med_profs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:med_profs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create med_prof" do
    assert_difference('MedProf.count') do
      post :create, med_prof: { about: @med_prof.about, latitude: @med_prof.latitude, longitude: @med_prof.longitude, name: @med_prof.name, type: @med_prof.type, user_id: @med_prof.user_id }
    end

    assert_redirected_to med_prof_path(assigns(:med_prof))
  end

  test "should show med_prof" do
    get :show, id: @med_prof
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @med_prof
    assert_response :success
  end

  test "should update med_prof" do
    patch :update, id: @med_prof, med_prof: { about: @med_prof.about, latitude: @med_prof.latitude, longitude: @med_prof.longitude, name: @med_prof.name, type: @med_prof.type, user_id: @med_prof.user_id }
    assert_redirected_to med_prof_path(assigns(:med_prof))
  end

  test "should destroy med_prof" do
    assert_difference('MedProf.count', -1) do
      delete :destroy, id: @med_prof
    end

    assert_redirected_to med_profs_path
  end
end
