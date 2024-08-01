# frozen_string_literal: true

module RepositoryCheckWorkflowStub
  class << self
    def clean_work_dir(*); end

    def clone_repo(*)
      '13e806c'
    end

    def run_check(*)
      {
        'files' => [
          {
            'path' => 'Gemfile',
            'offenses' => []
          },
          {
            'path' => 'abc.gemspec',
            'offenses' => []
          }
        ]
      }
    end
  end
end
