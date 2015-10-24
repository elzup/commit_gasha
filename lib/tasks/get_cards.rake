require 'open-uri'
require 'fileutils'

namespace :get_cards do
  desc 'get card infos'
  task :run => :environment do
    url = 'https://github.com/isaisstillalive/imas_cg_hash/raw/master/id2hash.json'
    res = open(url)
    # check status code
    if res.status[0] != '200'
      puts "#{res.status} #{url}"
    end
    datas = JSON.parse(res.read)
    datas.each do |imas_id, value|
      Card.hash_regist(imas_id.to_i, value)
    end
  end
end
