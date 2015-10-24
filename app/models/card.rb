class Card < ActiveRecord::Base

  def self.hash_regist(imas_id, value)
    Card.create(
        title: value['name'],
        imas_id: imas_id,
        imas_hash: value['hash']
    )
  end
end
