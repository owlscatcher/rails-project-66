# frozen_string_literal: true

class RepositoryCheckRunner
  include Dry::AutoInject(ApplicationContainer)['repository_check_workflow']

  def run(repository_check)
    return unless repository_check.may_start?

    repository_check.start!

    work_dir = Rails.root.join('tmp/repos', repository_check.id.to_s)
    commit_id = repository_check_workflow.clone_repo(repository_check.repository.clone_url, work_dir)
    linter = "Linter::#{repository_check.repository.language.capitalize}Linter".constantize.new
    result = repository_check_workflow.lint_repo(linter.command, work_dir)
    files = linter.build_files_with_problems(result, work_dir)

    files.each do |file|
      check_file = Repository::Check::File.create(path: file.path, check: repository_check)

      file.problems.each do |problem|
        Repository::Check::Problem.create(
          rule: problem.rule,
          message: problem.message,
          location: problem.location,
          file: check_file,
          check: repository_check
        )
      end
    end

    repository_check.commit_id = commit_id
    repository_check.passed = repository_check.problems.count.zero?
    repository_check.save

    repository_check_workflow.clean_work_dir(work_dir)
    repository_check.finish!

    RepositoryCheckMailer.check_have_problems(repository_check.id).deliver_later unless repository_check.passed
  rescue StandardError => e
    Rails.logger.error e

    repository_check_workflow.clean_work_dir(work_dir)
    repository_check.fail!

    RepositoryCheckMailer.check_failed(repository_check.id).deliver_later
  end
end
