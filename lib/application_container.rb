# frozen_string_literal: true

class ApplicationContainer
  extend Dry::Container::Mixin

  if Rails.env.test?
    register(:octokit_client) { OctokitClientStub }
    register(:repository_check_workflow_stub) { RepositoryCheckWorkflowStub }
  else
    register(:octokit_client) { Octokit::Client }
    register(:repository_check_workflow) { RepositoryCheckWorkflow }
  end
end
