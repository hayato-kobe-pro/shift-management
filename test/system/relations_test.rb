require "application_system_test_case"

class RelationsTest < ApplicationSystemTestCase
  setup do
    @relation = relations(:one)
  end

  test "visiting the index" do
    visit relations_url
    assert_selector "h1", text: "Relations"
  end

  test "creating a Relation" do
    visit relations_url
    click_on "New Relation"

    fill_in "Room", with: @relation.room_id
    fill_in "User", with: @relation.user_id
    click_on "Create Relation"

    assert_text "Relation was successfully created"
    click_on "Back"
  end

  test "updating a Relation" do
    visit relations_url
    click_on "Edit", match: :first

    fill_in "Room", with: @relation.room_id
    fill_in "User", with: @relation.user_id
    click_on "Update Relation"

    assert_text "Relation was successfully updated"
    click_on "Back"
  end

  test "destroying a Relation" do
    visit relations_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Relation was successfully destroyed"
  end
end
