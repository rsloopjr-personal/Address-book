require "application_system_test_case"

class ContactGroupsTest < ApplicationSystemTestCase
  setup do
    @contact_group = contact_groups(:one)
  end

  test "visiting the index" do
    visit contact_groups_url
    assert_selector "h1", text: "Contact Groups"
  end

  test "creating a Contact group" do
    visit contact_groups_url
    click_on "New Contact Group"

    fill_in "Group name", with: @contact_group.group_name
    click_on "Create Contact group"

    assert_text "Contact group was successfully created"
    click_on "Back"
  end

  test "updating a Contact group" do
    visit contact_groups_url
    click_on "Edit", match: :first

    fill_in "Group name", with: @contact_group.group_name
    click_on "Update Contact group"

    assert_text "Contact group was successfully updated"
    click_on "Back"
  end

  test "destroying a Contact group" do
    visit contact_groups_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Contact group was successfully destroyed"
  end
end
