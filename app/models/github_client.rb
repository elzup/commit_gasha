class GithubClient
  def self.user(token)
    JSON.parse(RestClient.get("https://api.github.com/user?access_token=#{token}"))
  end

  def self.events(username)
    JSON.parse(RestClient.get("https://api.github.com/users/#{username}/events"))
  end

  def self.push_events(username)
    events = GithubClient.events(username)
    events.select { |event| event['type'] == 'PushEvent' }
  end

  def self.commits(username)
    events = GithubClient.push_events(username)
    commits = []
    events.each do |event|
      commits += event['payload']['commits']
    end
    commits
  end
end