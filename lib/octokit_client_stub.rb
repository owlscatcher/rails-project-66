# frozen_string_literal: true

Repos = Struct.new(:id, :name, :full_name, :language, :clone_url, :ssh_url, :html_url)

class OctokitClientStub
  REPOS = [
    Repos.new(
      1,
      'repository1',
      'user/repository1',
      'ruby',
      'https://github.com/user/repository1.git',
      'git@github.com:user/repository1.git'
    ),
    Repos.new(
      2,
      'repository2',
      'user/repository2',
      'ruby',
      'https://github.com/user/repository2.git',
      'git@github.com:user/repository2.git'
    ),
    Repos.new(
      3,
      'repository3',
      'user/repository3',
      'JavaScriipt',
      'https://github.com/user/repository3.git',
      'git@github.com:user/repository3.git'
    ),
    Repos.new(
      4,
      'repository4',
      'user/repository4',
      nil,
      'https://github.com/user/repository4.git',
      'git@github.com:user/repository4.git'
    )
  ].freeze

  def initialize(*); end

  def repos(*)
    REPOS
  end

  def repo(*)
    REPOS.first
  end

  def create_hook(*); end
end
