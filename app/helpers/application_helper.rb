module ApplicationHelper

  def facebook_url(uid)
    "https://www.facebook.com/#{uid}"
  end

  def facebook_picture_url(uid)
    "https://graph.facebook.com/#{uid}/picture?width=150&height=150"
  end

  def adorable_url(uuid)
    "http://api.adorable.io/avatars/150/#{uuid}"
  end

  def profile_image_url(user)
    if user.with_facebook?
      facebook_picture_url(user.facebook.uid)
    else
      adorable_url(user.uuid)
    end
  end

  def background_image_url(url)
    if url.present?
      {style: "background-image: url('#{url}')"}
    else
      {}
    end
  end

  def nl2p(target)
    html = ""

    if target.present?
      target.gsub(/(\r\n|\r|\n)/, "\r\n").split(/\r\n/).select { |c| c.strip.size > 0 }.each do |chunk|
        html << "<p>#{chunk}</p>" if chunk.strip.size > 0
      end
    end

    html.html_safe
  end

  def three_dots(target, limit)
    if target.present? && target.length > limit
      target.slice(0, limit) + "..."
    else
      target
    end
  end
end
