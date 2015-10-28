class User < ActiveRecord::Base
  has_many :gashas
  has_many :cards, through: :gashas

  validates :name, presence: true

  # API リクエストで取ってきたコミット
  def fetch_commits
    @fetch_commits ||= GithubClient.commits(username)
  end

  # 新しいコミット
  def uninserted_commits
    fetch_commits.select { |commit| !Gasha.exists?(commit_id: commit['url']) }
  end

  # gasha に新しいコミットを登録する
  # @return [Number] new inserted commit count
  def import_commits
    pp fetch_commits
    pp uninserted_commits
    insert_gashas = []
    uninserted_commits.each do |commit|
      insert_gashas << gashas.build(turned: false, commit_id: commit['url'])
    end
    if insert_gashas
      Gasha.import insert_gashas
    end
    insert_gashas.count
  end

  # gasha に使用していないコミット
  def unturned_gashas
    gashas.where(turned: false)
  end

  def unturned_gashas_count
    unturned_gashas.count
  end
  alias :remain_commit_num :unturned_gashas_count

  def set_gitinfo(github)
    @github = github
  end

  def gashas_count
    gashas.count
  end

  def username
    @username = @github['login']
  end

  def can_turn_card?
    uninserted_commits.count > 0
  end

  def turn_card
    card = Card.random_generate
    unless can_turn_card?
      return nil
    end
    commit = unturned_gashas.first
    commit.update_attribute(card_id: card.id)
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
