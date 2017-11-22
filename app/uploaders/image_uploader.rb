class ImageUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  # storage :file
  storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  # "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  def store_dir
    if model.class.to_s.underscore == "user_info"
      "uploads/user/#{model.hash_id}/#{model.id}"
    else
      "uploads/user/#{model.user.user_info.hash_id}/#{model.class.to_s.underscore}/#{model.id}"
    end
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url(*args)
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process scale: [150, 150]
  #
  # def scale(width, height)
  #   # do something
  # end


  # 画像の上限を150pxにする
  # process :resize_to_fit => [150, 150]
  # 中央切り抜き
  process :resize_to_fill => [150, 150, Magick::CenterGravity]

  # Create different versions of your uploaded files:
  version :thumb do
    # 中央切り抜き
    process resize_to_fill: [50, 50, Magick::CenterGravity]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  def filename
    super.chomp(File.extname(super)) + '.jpg' if original_filename.present?
  end

  # 保存形式をJPGにする
  process :convert => 'jpg'

end
