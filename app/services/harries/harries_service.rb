module HarriesService
  include BaseService
  module_function

  def index
    Post.order(created_at: :desc).limit(12)
  end
end
