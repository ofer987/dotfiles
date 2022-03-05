# frozen_string_literal: true

# require 'pry-byebug'

class GitHub
  REGEX = %r{github\.com[/:](.*)\.git\b}
  # REGEX_HTTPS = /github\.com\/(.*)\.git\b/

  def self.github_repos
    repos = `git remote -v`.chomp.split("\n")

    # binding.pry
    repos
      .map { |item| REGEX.match(item) }
      .filter { |item| item.size >= 2 }
      .map { |item| item[1] }
      .uniq
  end

  def initialize(username, password)
    @username = username
    @password = password

    @client = Octokit::Client.new(
      login: @username,
      password: @password
    )
  end

  def my_pull_requests(branch_name)
    results = GitHub.github_repos.flat_map do |item|
      @client.pull_requests(item, state: 'open')
    end

    results
      .select { |item| item.user.login == @username && item.head.ref == branch_name }
      .sort_by(&:updated_at)
      .reverse
  end

  def create_branch_url(branch_name)
    "#{Git.repo_url}/compare/#{Git.merge_branch_name}...#{branch_name}"
  end
end
