module ApplicationHelper

  def facebook_url(uid)
    "https://www.facebook.com/#{uid}"
  end

  def facebook_picture_url(uid)
    "https://graph.facebook.com/#{uid}/picture?width=150&height=150"
  end

  def profile_image_url(user)
    if user.with_facebook?
      facebook_picture_url(user.facebook.uid)
    else
      asset_path("anonymous.jpg")
    end
  end

  def background_image_url(url)
    if url.present?
      {style: "background-image: url('#{url}')"}
    else
      {}
    end
  end
end
