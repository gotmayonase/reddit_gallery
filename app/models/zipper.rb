class Zipper

  def self.zip_with_backgrounds(backgrounds, filename=nil)
    id_string = Digest::MD5.new.hexdigest(backgrounds.map(&:id).join(','))
    filename ||= File.join(Rails.root,"public","r","#{id_string}.zip")
    unless File.exists?(filename)
      Zip::File.open(filename, Zip::File::CREATE) do |zipfile|
        backgrounds.each do |background|
          zipfile.add("#{background.reddit_id}#{File.extname(background.image_file_name)}", background.image.path)
        end
      end
    end
    filename
  end

end
