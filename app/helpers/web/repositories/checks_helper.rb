# frozen_string_literal: true

module Web::Repositories::ChecksHelper
  def link_to_github_commit(check)
    check.commit_id ? link_to(check.commit_id, build_commit_url(check), target: :blank) : ''
  end

  def build_commit_url(check)
    [check.repository.clone_url.gsub(/\.git$/, ''), 'commit', check.commit_id].join('/')
  end
end
