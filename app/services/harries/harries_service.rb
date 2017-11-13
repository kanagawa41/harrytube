module HarriesService
  include BaseService
  module_function

  def index
    Post.order(created_at: :desc).page(@page)
  end
end
