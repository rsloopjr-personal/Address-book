require 'test_helper'

class ContactGroupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @contact_group = contact_groups(:one)
  end

  test "should get index" do
    get contact_groups_url
    assert_response :success
  end

  test "should get new" do
    get new_contact_group_url
    assert_response :success
  end

  test "should create contact_group" do
    assert_difference('ContactGroup.count') do
      post contact_groups_url, params: { contact_group: { group_name: @contact_group.group_name } }
    end

    assert_redirected_to contact_group_url(ContactGroup.last)
  end

  test "should show contact_group" do
    get contact_group_url(@contact_group)
    assert_response :success
  end

  test "should get edit" do
    get edit_contact_group_url(@contact_group)
    assert_response :success
  end

  test "should update contact_group" do
    patch contact_group_url(@contact_group), params: { contact_group: { group_name: @contact_group.group_name } }
    assert_redirected_to contact_group_url(@contact_group)
  end

  test "should destroy contact_group" do
    assert_difference('ContactGroup.count', -1) do
      delete contact_group_url(@contact_group)
    end

    assert_redirected_to contact_groups_url
  end
end
