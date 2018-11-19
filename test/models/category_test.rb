require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  setup do
    @category = categories(:one)
  end

  def test_invalid_without_name
    @category.name = ''
    assert @category.invalid?
  end
end
