class Card < ActiveRecord::Base
  IMAGE_URL = 'http://125.6.169.35/idolmaster/image_sp/card/m/'

  def img_path
    "#{IMAGE_URL}#{imas_hash}.jpg"
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
