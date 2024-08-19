# frozen_string_literal: true

module RepositoryCheckWorkflowStub
  class << self
    def clean_work_dir(*); end

    def clone_repo(*)
      '028f342'
    end

    def lint_repo(*)
      {
        'files' => [
          {
            'path' => 'app/controllers/api/checks_controller.rb',
            'offenses' => []
          },
          {
            'path' => 'app/controllers/application_controller.rb',
            'offenses' => []
          }
        ]
      }
    end
  end
end
