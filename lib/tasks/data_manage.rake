require 'open-uri'
require 'fileutils'

namespace :data_manage do
  desc 'get cards infos'
  task :get_cards => :environment do
    url = 'https://github.com/isaisstillalive/imas_cg_hash/raw/master/id2hash.json'
    res = open(url)
    # check status code
    if res.status[0] != '200'
      puts "Error: #{res.status} #{url}"
      return
    end
    datas = JSON.parse(res.read)
    datas.each do |imas_id, value|
      Card.hash_regist(imas_id.to_i, value)
    end
  end

  desc 'get cards rank data'
  task :update_rank => :environment do
    # 上二桁目で判断
    Card.all.each do |card|
      card.update_rank_from_id
    end
  end

  desc 'get cards rank data'
  task :reset_gasha_new_param => :environment do
    Gasha.update_all(turned: false, card_id: nil)
  end
end
