module ApplicationHelper
  def gravatar_for(user, options = { size: 180 })
    email_address = user.email
    size = options[:size]
    hash = Digest::MD5.hexdigest(email_address)
    gravatar_url = "https://www.gravatar.com/avatar/#{hash}?s=#{size}"
    image_tag(gravatar_url, alt: user.username, class: 'rounded shadow mx-auto d-block')
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_user
    unless logged_in?
      flash[:warning] = 'You must be logged in to perform that action'
      redirect_to login_path
    end
  end
end
