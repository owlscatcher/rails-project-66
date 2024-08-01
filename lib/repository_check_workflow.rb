# frozen_string_literal: true

module RepositoryCheckWorkflow
  class << self
    def prepare_work_dir(work_dir)
      clean_work_dir work_dir
      FileUtils.mkdir_p work_dir
    end

    def clean_work_dir(work_dir)
      FileUtils.rm_rf work_dir
    end

    def clone_repo(clone_url, work_dir)
      prepare_work_dir work_dir

      _, _, status = Open3.capture3("git clone #{clone_url} .", chdir: work_dir)
      raise "Failed to clone repository from #{clone_url}" unless status.success?

      last_commit_sha, = Open3.capture3('git log --format="%h" -n 1', chdir: work_dir)

      last_commit_sha.chomp
    end

    def lint_repo(command, work_dir)
      result, = Open3.capture3(command, chdir: work_dir)

      JSON.parse(result)
    end
  end
end
