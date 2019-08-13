require "application_system_test_case"

class ShareInvitesTest < ApplicationSystemTestCase
  setup do
    @share_invite = share_invites(:one)
  end

  test "visiting the index" do
    visit share_invites_url
    assert_selector "h1", text: "Share Invites"
  end

  test "creating a Share invite" do
    visit share_invites_url
    click_on "New Share Invite"

    fill_in "Contact group", with: @share_invite.contact_group_id
    fill_in "Receiver", with: @share_invite.receiver_id
    fill_in "Sharer", with: @share_invite.sharer_id
    fill_in "Status", with: @share_invite.status
    click_on "Create Share invite"

    assert_text "Share invite was successfully created"
    click_on "Back"
  end

  test "updating a Share invite" do
    visit share_invites_url
    click_on "Edit", match: :first

    fill_in "Contact group", with: @share_invite.contact_group_id
    fill_in "Receiver", with: @share_invite.receiver_id
    fill_in "Sharer", with: @share_invite.sharer_id
    fill_in "Status", with: @share_invite.status
    click_on "Update Share invite"

    assert_text "Share invite was successfully updated"
    click_on "Back"
  end

  test "destroying a Share invite" do
    visit share_invites_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Share invite was successfully destroyed"
  end
end
