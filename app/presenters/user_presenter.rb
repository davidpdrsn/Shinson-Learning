class UserPresenter < Presenter
  presents :user
  delegate :email, to: :user

  def first_name
    if user.first_name.present?
      user.first_name
    else
      'n\a'
    end
  end

  def last_name
    if user.last_name.present?
      user.last_name
    else
      'n\a'
    end
  end

  def name
    if has_full_name(user)
      "#{user.first_name} #{user.last_name}"
    else
      "None given"
    end
  end

  def screen_name
    if users_first_and_or_last_name.present?
      users_first_and_or_last_name
    else
      user.email
    end
  end

  def name_with_s
    if ends_in_s(screen_name)
      "#{screen_name}'"
    else
      "#{screen_name}'s"
    end
  end

  def link_to_user
    h.link_to screen_name, user
  end

  def mailto_link
    h.mail_to email, email
  end

  def edit_link
    h.link_to "Edit information",
              h.edit_user_registration_path,
              class: "button"
  end

  def destroy_link
    h.link_to "Delete account",
              h.registration_path(user),
              data: { confirm: "Are you sure?" },
              method: :delete,
              class: "button button--red"
  end

  private

  def ends_in_s(screen_name)
    screen_name.match /s$/
  end

  def has_full_name(user)
    user.first_name && user.last_name
  end

  def users_first_and_or_last_name
    [user.first_name, user.last_name].
      reject(&:blank?).
      map(&:titleize).
      join(" ")
  end
end
