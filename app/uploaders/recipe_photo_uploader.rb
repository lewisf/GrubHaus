class RecipePhotoUploader < CarrierWave::Uploader::Base
  storage :fog
  process :resize_to_fill => [300,300]
end
