# frozen_string_literal: true

require 'test_helper'

class Web::RepositoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @attrs = { github_id: 1 }
    @repository = repositories(:one)
    @response_body = load_fixture('files/response.json')
    @stub = stub_request(:get, 'https://api.github.com/user/repos?per_page=100')
            .to_return(status: 200, body: @response_body, headers: { 'Content-Type' => 'application/json' })

    sign_in @user
  end

  test 'should get index' do
    get repositories_url
    assert_response :success
  end

  test 'should get new' do
    get new_repository_url
    assert_response :success
  end

  test 'should create repository' do
    post repositories_url, params: { repository: @attrs }
    repository = Repository.find_by @attrs

    assert { repository }
    assert_redirected_to repositories_url
  end

  test 'should show repository' do
    get repository_url(@repository)
    assert_response :success
  end
end
