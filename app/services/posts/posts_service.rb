module PostsService
  include BaseService
  module_function

  def show(post)
    is_favorite = $current_user.present? ? Favorite.exists?(post_id: post.id, user_id: $current_user.user_info.user_id) : nil
    favorite_size = Favorite.where(post_id: post.id).count

    [post.comments, is_favorite, favorite_size]
  end
end
