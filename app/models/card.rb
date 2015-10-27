class Card < ActiveRecord::Base
  has_many :gashas
  has_many :users, through: :gashas
  IMAGE_URL = 'http://125.6.169.35/idolmaster/image_sp/card/m/'
  # HACK
  RANK_N = 0
  RANK_NP = 1
  RANK_R = 2
  RANK_RP = 3
  RANK_SR = 4
  RANK_SRP = 5

  def img_path
    "#{IMAGE_URL}#{imas_hash}.jpg"
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
    Card.create(
        title: value['name'],
        imas_id: imas_id,
        imas_hash: value['hash']
    )
  end

  def self.random_generate
    Card.find(Card.random_id)
  end

  def self.random_id
    Random.new.rand(0..Card.count)
  end
end
