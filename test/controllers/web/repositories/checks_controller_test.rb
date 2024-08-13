# frozen_string_literal: true

require 'test_helper'

class Web::Repositories::ChecksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @repository = repositories(:one)
    @repository_check = repository_checks(:one)

    @user = users(:one)
    @other_user = users(:two)
  end

  test 'should create new check' do
    sign_in @user

    assert_difference 'Repository::Check.count', 1 do
      post repository_checks_path(@repository), params: { repository_id: @repository.id }
    end
  end

  test "should not create new check for other user's repository" do
    sign_in @other_user

    assert_no_difference 'Repository::Check.count' do
      post repository_checks_path(@repository), params: { repository_id: @repository.id }
    end
  end

  test 'should not create new check if not signed in' do
    post repository_checks_path(@repository), params: { repository_id: @repository.id }

    assert_redirected_to root_url
  end
end
