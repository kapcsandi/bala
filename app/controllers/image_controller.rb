class ImageController < ApplicationController
  before_filter :root_authorize

  def index
    @errors = []
    if params[:image]
      @name = params[:image][:file].original_filename.downcase.to_s
      directory = "public/uploads/Image"
      path = File.join(directory, @name)
      File.open(path, "wb") { |f| f.write(params[:image][:file].read) }
      @name.sub!(/\..*$/,'')

      @house = @name.scan(/\d+/)[0..-2].join('-')
      begin
        house = House.find_by_code(@house)
      rescue
      end
      if house
        @errors << "A #{house.code} apartman létezik."
        directory = 'public/pic/' + house.stripped_code
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
          newpath = File.join(directory,@name + "_#{d[0]}.jpg")
          begin
            image.write(newpath)
            @errors << "A #{newpath.inspect} fájl létrehozása sikerült."
          rescue
            @errors << "A #{newpath.inspect} fájl létrehozása nem sikerült."
          end
        end
        ids = house.picture_ids
        if params[:image][:first] == 1
          ids.insert(0, @name)
        else
          ids << @name
        end
        house.picture_ids = ids
        begin
          house.save
        rescue
          @errors << "A #{@name} kép hozzáadása az apartman képgalériájához nem sikerült."
        end
        @errors << "A #{@name} kép hozzáadása az apartman képgalériájához sikerült."
        @errors << "A #{@name} kép feltöltése sikerült."
      else
        @errors << "Az apartman nem létezik vagy nem megfelelő a fájl neve. Példa a helyes fájlnévre: 24-305-02_01.jpg"
      end
    end
  end
end
