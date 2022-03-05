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
end
