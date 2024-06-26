# frozen_string_literal: true

class Git
  DEFAULT_REMOTE = 'origin'

  def self.username
    `git config user.username`.strip
  end

  def self.remote_name(name)
    name = name.to_s.strip

    return name unless name.empty?

    `git config --get branch.#{branch_name}.remote`.chomp
  end

  def self.origin_url
    `git config remote.origin.url`.strip
  end

  def self.repo_url
    url = origin_url

    if %r{\.git$}.match? url
      url = url.gsub(%r{\.git}, '')
    end

    if %r{^https://}.match? url
      return url
    elsif %r{^git\@}.match? url
      url = url
        .gsub(%r{^git\@}, 'https://')
        .gsub(%r{(https://.*):(.*)\/(.*)}, "\\1/\\2/\\3")
    else
      raise "Sorry, but #{url} is not valid"
    end
  end

  def self.branch_name
    `git rev-parse --abbrev-ref HEAD`.chomp
  end

  def self.repo_directory
    `git rev-parse --show-toplevel 2> /dev/null`.chomp
  end

  def self.local_file_path(absolute_file_path)
    absolute_file_path.delete_prefix(repo_directory)
  end
end
