require "open_graph_helper/version"
require 'open_graph_helper/railtie' if defined?(Rails)

# http://developers.facebook.com/docs/opengraph/
module OpenGraphHelper
  def og_title(content)
    "<meta property='og:title' content='#{content}'/>"
  end

  def og_description(content)
    content = html_escape(strip_tags(content))
    "<meta property='og:description' content='#{truncate(content , :length => 100)}'/>"
  end

  def og_type(content = "article")
    "<meta property='og:type' content='#{content}'/>"
  end

  # 50x50 px ~ 150x150 px
  def og_image(content)
    "<meta property='og:image' content='#{content}'/>"
  end

  def og_url(content)
    "<meta property='og:url' content='#{content}'/>"
  end

  def og_site_name(content)
    "<meta property='og:site_name' content='#{content}'/>"
  end

  def og_fb_app_id(content)
    tag(:meta, { :property => "fb:app_id", :content => content }, true)
  end

  def og_fb_admins(content)
    tag(:meta, { :property => "fb:admins", :content => content }, true)
  end

  # types: icon, icon_link, button, button_count, box_count
  def fb_share_link(share_url, type = "button_count", script = false)
    output = link_to("分享", "http://www.facebook.com/sharer.php", :name => "fb_share", :share_url => share_url, :type => type, :class => "facebook fb-share")
    output << content_tag(:script, "", :src => "http://static.ak.fbcdn.net/connect.php/js/FB.Share", :type => "text/javascript") if script
    output
  end

  # types: button_count, standard
  def fb_like_iframe(like_url, type = "button_count", size = "85x21")
    width, height = size.split("x")
    src = "http://www.facebook.com/plugins/like.php?href=#{like_url}&locale=zh_TW&layout=#{type}&show_faces=true&action=like&colorscheme=light&width=#{width}&height=#{height}"
    style = "border:none; overflow:hidden; width:#{width}px; height:#{height}px;"
    content_tag(:iframe, "", :src => src, :scrolling => "no", :frameborder => "0", :style => style, :allowtransparency => "true")
  end

  def fb_likebox_iframe(like_url, size = "240x65")
    width, height = size.split("x")
    src =  "http://www.facebook.com/plugins/likebox.php?href=#{like_url}&connections=0&stream=false&header=true&colorscheme=light&width=#{width}&height=#{height}"
    style = "border:none; overflow:hidden; width:#{width}px; height:#{height}px;"
    content_tag(:iframe, "", :src => src, :scrolling => "no", :frameborder => "0", :style => style, :allowtransparency => "true")
  end

  def fb_recommendation_iframe(site_url, size = "300x380")
    width, height = size.split("x")
    src = "http://www.facebook.com/plugins/recommendations.php?site=#{site_url}&header=false&colorscheme=light&border_color=%23CCCCCC&width=#{width}&height=#{height}"
    style = "border:none; overflow:hidden; width:#{width}px; height:#{height}px;"
    content_tag(:iframe, "", :src => src, :scrolling => "no", :frameborder => "0", :style => style, :allowtransparency => "true")
  end
end
