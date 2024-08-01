# frozen_string_literal: true

module Linter
  class RubyLinter < BaseLinter
    def command
      "rubocop -f json -c #{Rails.root.join('lib/linter/configs/rubocop.yml')}"
    end

    def build_files_with_problems(result, _work_dir)
      result['files']
        .reject { |file| file['offenses'].empty? }
        .map do |file|
          problems = file['offenses'].map do |offense|
            build_problem(
              rule: offense['cop_name'],
              message: offense['message'],
              location: "#{offense['location']['line']}:#{offense['location']['column']}"
            )
          end

          build_file(path: file['path'], problems:)
        end
    end
  end
end
