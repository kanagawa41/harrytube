module PostsService
  include BaseService
  module_function

  def show(post)
    post.comments
  end
end
