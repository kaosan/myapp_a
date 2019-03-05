module UsersHelper
  def new_or_edit
    if action_name == 'new' || action_name == 'confirm'
      confirm_posts_path
    elsif action_name == 'edit'
      user_path
    end
  end

end
