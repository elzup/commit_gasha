class Gasha < ActiveRecord::Base
  belongs_to :user
  belongs_to :card

  def self.generate
    Card.random_generate
  end
end
