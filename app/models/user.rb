class User < ActiveRecord::Base

  validates :name, presence: true

  def commits
    @commits ||= GithubClient.commits(username)
  end

  def set_gitinfo(github)
    @github = github
  end

  def username
    @username ||= @github['login']
  end

  def self.login_user(token)
    # ログインしているユーザを返す, セッションがなければnil
    if token.nil?
      return nil
    end
    user_info = GithubClient.user(token)
    user = User.find_or_create_by(github_id: user_info['id'])
    user.set_gitinfo(user_info)
    user
  end
end
