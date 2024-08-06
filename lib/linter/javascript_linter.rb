# frozen_string_literal: true

module Linter
  class JavascriptLinter < BaseLinter
    def command
      "node --no-warnings \
        #{Rails.root.join('node_modules/.bin/eslint')} . \
        -c #{Rails.root.join('lib/linter/configs/.eslintrc.yml')} \
        -f json \
        --no-eslintrc"
    end

    def build_files_with_problems(result, work_dir)
      result
        .reject { |file| file['errorCount'].zero? }
        .map do |file|
          problems = file['messages'].map do |msg|
            build_problem(
              rule: msg['ruleId'],
              message: msg['message'],
              location: "#{msg['line']}:#{msg['column']}"
            )
          end

          build_file(path: file['filePath'].sub!(work_dir.to_s, ''), problems:)
        end
    end
  end
end
