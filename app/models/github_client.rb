class GithubClient
  def self.user(token)
    JSON.parse(RestClient.get("https://api.github.com/user?access_token=#{token}"))
  end

  def self.events(username)
    JSON.parse(RestClient.get("https://api.github.com/users/#{username}/events"))
  end

  def self.repos(username)
    # TODO: api default count
    params = { sort: :updated }
    JSON.parse(RestClient.get("https://api.github.com/users/#{username}/repos", params: params))
  end

  def self.push_events(username)
    events = GithubClient.events(username)
    events.select { |event| event['type'] == 'PushEvent' }
  end

  def self.repo_commits(repo)
    JSON.parse(RestClient.get("https://api.github.com/repos/#{repo['full_name']}/commits"))
  end

  def self.commits(username)
    repos = GithubClient.repos(username)
    commits = []
    repos[0...10].each do |repo|
      commits += repo_commits(repo)
    end
    commits
  end

  def self.event_commits(username)
    events = GithubClient.push_events(username)
    commits = []
    events.each do |event|
      commits += event['payload']['commits']
    end
    commits.uniq { |commit| commit['url'] }
  end
end