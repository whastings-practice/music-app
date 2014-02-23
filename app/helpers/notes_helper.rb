module NotesHelper
  def user_can_delete_note?(note)
    user_is_admin? || (current_user && current_user == note.user)
  end
end
