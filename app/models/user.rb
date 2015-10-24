class User < ActiveRecord::Base
  has_many :gashas
  has_many :cards, through: :gashas

  validates :name, presence: true

  def commits
    @commits ||= GithubClient.commits(username)
  end

  def unused_commits
    @unused_commits ||= commits.select { |commit| !Gasha.exists?(commit_id: commit['url']) }
  end

  def set_gitinfo(github)
    @github = github
  end

  def username
    @username ||= @github['login']
  end

  def can_turn_card?
    @can_turn_card ||= unused_commits.first
  end

  def turn_card
    card = Card.random_generate
    unless can_turn_card?
      return nil
    end
    commit_id = unused_commits.first['url']
    gashas.create(card_id: card.id, commit_id: commit_id)
    card
  end

  def self.login_user(token)
    # ログインしているユーザを返す, セッションがなければnil
    if token.nil?
      return nil
    end
    user_info = GithubClient.user(token)
    user = User.find_or_create_by(name: user_info['login'], github_id: user_info['id'])
    if user.new_record?
      user.save!
    end
    user.set_gitinfo(user_info)
    user
  end
end
