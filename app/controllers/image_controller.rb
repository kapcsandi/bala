class ImageController < ApplicationController
  before_filter :authorize

  def index
    @errors = []
    if params[:image]
      @name = params[:image][:file].original_filename.downcase.to_s
      directory = "public/uploads/Image"
      path = File.join(directory, @name)
      File.open(path, "wb") { |f| f.write(params[:image][:file].read) }

      @house = @name.scan(/(^[0-9\-]+)_/)
      directory = 'public/pic/' + @house[0][0]
      if File.exists?(directory)
        @errors << "A #{directory.inspect} könyvtár már létezik."
      else
        begin
          Dir.mkdir(directory)
        rescue
          @errors << "A #{directory.inspect} könyvtár létrehozása nem sikerült."
        end
      end

      [['s','x90'], ['m', 'x140'], ['l', 'x400']].each do |d|
        image = MiniMagick::Image.from_file(path)
        image.combine_options do |c|
          c.resize d[1]
        end
        newpath = File.join(directory,@name.sub('.jpg',"_#{d[0]}.jpg"))
        begin
          image.write(newpath)
          @errors << "A #{newpath.inspect} fájl létrehozása sikerült."
        rescue
          @errors << "A #{newpath.inspect} fájl létrehozása nem sikerült."
        end
      end
    end
  end
end
