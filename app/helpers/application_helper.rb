module ApplicationHelper
  def controller?(*controller)
    controller.include?(params[:controller])
  end

  def action?(*action)
    action.include?(params[:action])
  end

  def image_tag_lazy(src, options={})
    options[:data] = { src: image_path(src) }
    options[:class] = 'lazyload'
    image_tag(image_path('loading.svg'), options)
  end
end
