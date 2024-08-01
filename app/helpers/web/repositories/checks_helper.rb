# frozen_string_literal: true

module Web::Repositories::ChecksHelper
  def link_to_github_commit(check, options = {})
    check.commit_id ? link_to(check.commit_id, build_commit_url(check), options.merge(target: :blank)) : ''
  end

  def link_to_github_file(check, path, options = {})
    check.commit_id ? link_to(path, build_path_url(check, path), options.merge(target: :blank)) : ''
  end

  def build_commit_url(check)
    [check.repository.clone_url.gsub(/\.git$/, ''), 'commit', check.commit_id].join('/')
  end

  def build_path_url(check, path)
    [check.repository.clone_url.gsub(/\.git$/, ''), 'tree', check.commit_id, path].join('/')
  end
end
