# frozen_string_literal: true

require 'test_helper'

class Web::RepositoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @other_user = users(:two)
    @attrs = { github_id: 918_273_645 }
    @repository = repositories(:one)
  end

  test 'should get index' do
    sign_in @user

    get repositories_url
    assert_response :success
  end

  test 'should get new' do
    sign_in @user

    get new_repository_url

    assert_response :success
  end

  test 'should create repository' do
    sign_in @user

    post repositories_url, params: { repository: @attrs }
    repository = Repository.find_by @attrs

    assert { repository }
    assert_redirected_to repositories_url
  end

  test 'should show repository' do
    sign_in @user

    get repository_url(@repository)
    assert_response :success
  end

  test 'should no access to other user repository' do
    sign_in @other_user

    get repository_url(@repository)
    assert_response :not_found
  end

  test 'should not show repository' do
    get repository_url(@repository)
    assert_redirected_to root_url
  end
end
