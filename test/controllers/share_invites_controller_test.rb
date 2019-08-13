require 'test_helper'

class ShareInvitesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @share_invite = share_invites(:one)
  end

  test "should get index" do
    get share_invites_url
    assert_response :success
  end

  test "should get new" do
    get new_share_invite_url
    assert_response :success
  end

  test "should create share_invite" do
    assert_difference('ShareInvite.count') do
      post share_invites_url, params: { share_invite: { contact_group_id: @share_invite.contact_group_id, receiver_id: @share_invite.receiver_id, sharer_id: @share_invite.sharer_id, status: @share_invite.status } }
    end

    assert_redirected_to share_invite_url(ShareInvite.last)
  end

  test "should show share_invite" do
    get share_invite_url(@share_invite)
    assert_response :success
  end

  test "should get edit" do
    get edit_share_invite_url(@share_invite)
    assert_response :success
  end

  test "should update share_invite" do
    patch share_invite_url(@share_invite), params: { share_invite: { contact_group_id: @share_invite.contact_group_id, receiver_id: @share_invite.receiver_id, sharer_id: @share_invite.sharer_id, status: @share_invite.status } }
    assert_redirected_to share_invite_url(@share_invite)
  end

  test "should destroy share_invite" do
    assert_difference('ShareInvite.count', -1) do
      delete share_invite_url(@share_invite)
    end

    assert_redirected_to share_invites_url
  end
end
