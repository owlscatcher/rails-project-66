# frozen_string_literal: true

require 'test_helper'

class Api::ChecksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @repository = repositories(:one)
  end

  test 'should hundle' do
    assert_difference 'Repository::Check.count', 1 do
      post api_checks_path({ repository: { id: @repository.github_id } })
    end

    assert_response :success
  end

  test 'should not hundle' do
    assert_no_difference 'Repository::Check.count', 1 do
      post api_checks_path({ repository: { id: 999_999_999 } })
    end

    assert_response :missing
  end
end
