require "test_helper"

class UserTest < ActiveSupport::TestCase

  test "should create wallet automatically" do

    user = User.create(
      name: "Rodrigo",
      email: "rodrigo@test.com"
    )

    assert user.wallet.present?

  end

  test "user should not save without name" do

    user = User.new(
      email: "teste@test.com"
    )

    assert_not user.save

  end

end