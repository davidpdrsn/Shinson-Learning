class UserPresenter < Presenter
  presents :user
  delegate :email, to: :user

  def name
    if user.first_name && user.last_name
      "#{user.first_name} #{user.last_name}"
    else
      "None given"
    end
  end

  def screen_name
    return user.email unless user.first_name || user.last_name

    [user.first_name, user.last_name].reject(&:blank?).map(&:to_s).map(&:titleize).join(" ")
  end

  def name_with_s
    if name.match /s$/
      "#{name}'"
    else
      "#{name}'s"
    end
  end

  def link_to_user
    h.link_to screen_name, user
  end

  def mailto_link
    h.mail_to email, email
  end
end
