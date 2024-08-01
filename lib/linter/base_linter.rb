# frozen_string_literal: true

module Linter
  Problem = Struct.new(:rule, :message, :location)
  File = Struct.new(:path, :problems)

  class BaseLinter
    def build_problem(rule:, message:, location:)
      Linter::Problem.new(rule:, message:, location:)
    end

    def build_file(path:, problems:)
      Linter::File.new(path:, problems:)
    end

    def command
      raise NotImplementedError
    end

    def build_files_with_problems
      raise NotImplementedError
    end
  end
end
