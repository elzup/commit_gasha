require 'open-uri'
require 'fileutils'

namespace :get_cards do
  desc 'card scrape'
  task :run do
    'detected'
    url = Rails.root.join('mytmp', 'index.html')
    image_dir = Rails.root.join('mytmp')

    charset = nil
    html = open(url) do |f|
      f.read
    end
    doc = Nokogiri::HTML.parse(html, nil, charset)
    picts = doc.css('.pict')
    picts[0, 10].each do |e|
      alt = e.attribute('alt')
      src = e.attribute('src')
      src_path = image_dir + src
      regist_card(src_path, alt)
    end
  end

  def regist_card(src_path, alt)
    save_dir = Rails.root.join('app', 'assets', 'images')
    Card.new(:title)
    # dst_path = save_dir +
    # FileUtils.mv(src_path, dst_path)

    #
  end
end
