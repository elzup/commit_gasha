class Card < ActiveRecord::Base
  has_many :gashas
  has_many :users, through: :gashas

  # HACK
  RANK_N = 0
  RANK_NP = 1
  RANK_R = 2
  RANK_RP = 3
  RANK_SR = 4
  RANK_SRP = 5

  def img_path
    @img_path ||= ImagePath.new(imas_hash)
  end

  def rank_from_imas_id
    # imas_id の上から2桁目
    imas_id.to_s[1].to_i
  end

  def update_rank_from_id
    # code here
    update_attribute(:rank, rank_from_imas_id)
  end

  def self.hash_regist(imas_id, value)
    Card.find_or_create_by(
        title: value['name'],
        imas_id: imas_id,
        imas_hash: value['hash']
    )
  end

  def self.random_generate(n=1)
    # N 88.5%
    # R 10%
    # SR 1.5%
    queues = {
        Card::RANK_N => 177,
        Card::RANK_R => 20,
        Card::RANK_SR => 3
    }
    ranks = WeightedRandomizer.new(queues).sample(n)
    ranks = ranks.map do |rank|
      Card.where(rank: rank).sample
    end
    n == 1 ? ranks[0] : ranks
  end

  def self.random_id
    Random.new.rand(0..Card.count)
  end

  # Rank にかかわらずランダムにサンプル
  def self.flat_sample(n=10)
    n.times.map { self.find( self.pluck(:id).sample ) }
  end
end
