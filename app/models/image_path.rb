class ImagePath
  IMAGE_URL = 'http://125.6.169.35/idolmaster/image_sp/card'
  IMAGE_URL_M = '/m/'
  IMAGE_URL_ICON = '/xs/'
  IMAGE_URL_COL = '/ls/'

  def initialize(hash)
    @hash = hash
  end

  def url(type=IMAGE_URL_M)
    "#{IMAGE_URL}#{type}#{@hash}.jpg"
  end

  def url_icon
    self.url(IMAGE_URL_ICON)
  end

  def url_col
    self.url(IMAGE_URL_COL)
  end
end