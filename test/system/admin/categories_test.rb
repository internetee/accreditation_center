require 'application_system_test_case'

class Admin::CategoriesTest < ApplicationSystemTestCase
  setup do
    sign_in administrators(:one)
    @category = categories(:one)
  end

  def test_new_category
    visit admin_categories_url
    click_on 'New category'
    fill_in 'Name', with: 'test'

    assert_changes 'Category.count' do
      click_on 'Create Category'
    end
    assert_text 'Category was successfully created'
  end

  def test_edit_category
    visit admin_categories_url
    click_on 'Edit', match: :first

    fill_in 'Name', with: 'new name'
    click_on 'Update Category'
    @category.reload

    assert_equal 'new name', @category.name
    assert_text 'Category was successfully updated'
  end
end
