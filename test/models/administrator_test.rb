require 'test_helper'

class AdministratorTest < ActiveSupport::TestCase
  def test_returns_string_representation
    admin = Administrator.new(email: 'john@registry.test')
    assert_equal 'john@registry.test', admin.to_s
  end
end
