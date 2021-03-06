class CurationUploader < CarrierWave::Uploader::Base

  include CarrierWave::RMagick

  storage :file

  def store_dir
    if @@staging
      "Admin_Test/Curation"
    else
      "Admin/Curation"
    end
  end

   def filename
     "#{@@filename}.#{@@file_extension}"
   end

   def temp_save_update_launcher(filename: nil, staging: nil)
     @@filename = filename
     @@file_extension = "zip"
     @@staging = false
     @@staging = true  if staging
   end
end
