module UsersHelper

  def user_form_url(user)
    user.persisted? ? user_url(user) : users_url
  end

  def user_submit_text(user)
    user.persisted? ? "Edit Account" : "Create Account"
  end

end
