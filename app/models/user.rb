class User < ActiveRecord::Base
  has_many :gashas
  has_many :cards, through: :gashas

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

  def turn_card
    card = Card.random_generate
    # TODO: to unused commit
    commit_id = commits[4]['url']
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
