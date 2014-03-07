class UserPresenter < Presenter
  presents :user

  def name
    if user.first_name && user.last_name
      "#{user.first_name} #{user.last_name}"
    else
      "None given"
    end
  end
end
