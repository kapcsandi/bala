class SetupController < ApplicationController
  require 'csv'
  
  def index
    @result = []
    empties = empties_helper

    if params['do']
      empties.each do |field|
        taggable = Taggable.find_or_create_by_field(field)
        case field
        when 'city_id':
        taggable.name = 'Település'
        taggable.context = 'Ház alapinfók'
        taggable.multi = false
        taggable.position = 0
        %w(Balatonakarattya Balatonszemes Siófok Balatonlelle).each do |city|
          taggable.tags << Tag.new( :name => city)
        end
        when 'house_type_id':
        taggable.name = 'Apartman típusa'
        taggable.context = 'Ház alapinfók'
        taggable.multi = false
        taggable.position = 3
        ['Apartmanház', 'Önálló ház', 'Ikerház', 'Házrész'].each do |house_type|
          taggable.tags << Tag.new( :name => house_type)
        end
        when 'condition_id':
        taggable.name = 'Állapot'
        taggable.context = 'Ház alapinfók'
        taggable.multi = false
        taggable.position = 4
        ['Új építésű', 'Felújított', 'Hagyományos'].each do |condition|
          taggable.tags << Tag.new( :name => condition)
        end
        when 'furnishing_id':
        taggable.name = 'Berendezés'
        taggable.context = 'Ház alapinfók'
        taggable.multi = false
        taggable.position = 5
        ['luxus', 'modern', 'jó minőségű', 'hagyományos'].each do |furnishing|
          taggable.tags << Tag.new( :name => furnishing)
        end
        when 'terrace_id':
        taggable.name = 'Terasz'
        taggable.context = 'Helyiségek'
        taggable.multi = false
        taggable.position = 18
        ['fedett', 'nyitott'].each do |terrace|
          taggable.tags << Tag.new( :name => terrace)
        end
        when 'balcony_id':
        taggable.name = 'Erkély'
        taggable.context = 'Helyiségek'
        taggable.multi = false
        taggable.position = 18
        ['fedett', 'nyitott', '2' ].each do |terrace|
          taggable.tags << Tag.new( :name => terrace)
        end
        when 'stove_id':
        taggable.name = 'Tűzhely'
        taggable.context = 'Konyha'
        taggable.multi = false
        taggable.position = 42
        ['elektromos', 'gáz', 'gáz + PB', 'főzőlap'].each do |stove|
          taggable.tags << Tag.new( :name => stove)
        end
        when 'clima_id':
        taggable.name = 'Klíma'
        taggable.context = 'Egyéb belső felszereltség'
        taggable.multi = false
        taggable.position = 45
        ['egész terület', 'földszint', 'emelet', 'mobil'].each do |clima|
          taggable.tags << Tag.new( :name => clima)
        end
        when 'parking_id':
        taggable.name = 'Parkoló'
        taggable.context = 'Egyéb külső felszereltség'
        taggable.multi = false
        taggable.position = 52
        ['zárt', 'zárt + garázs', 'utca', 'garázs', 'udvarban'].each do |parking|
          taggable.tags << Tag.new( :name => parking)
        end
        when 'owner_place_id':
        taggable.name = 'Háztulajdonos lakik'
        taggable.context = 'Háztulajdonos infók'
        taggable.multi = false
        taggable.position = 62
        ['külön épületben, szeparáltan', 'az épületben, szeparáltan', 'nem lakik ott'].each do |place|
          taggable.tags << Tag.new( :name => place)
        end
        when 'accomodation':
        taggable.name = 'Fekvés'
        taggable.context = 'Ház alapinfók'
        taggable.multi = true
        taggable.position = 6
        ['csendes', 'közvetlen vízparti', 'főút mellett', 'utcára néző', 'kertre néző'].each do |acc|
          taggable.tags << Tag.new( :name => acc)
        end
        when 'room_types_ground':
        taggable.name = 'Földszint'
        taggable.context = 'Helyiségek elrendezése'
        taggable.multi = true
        taggable.position = 8
        ['nincs', 'nappali', '1 hálószoba', '2 hálószoba', '3 hálószoba', '4 hálószoba', 'étkező', 'nappali + étkező + konyha', 'konyha', 'konyha + étkező', 'WC', 'WC + fürdő', 'tusoló', 'WC + tusoló', 'terasz', 'kertkapcsolat'].each do |rooms|
          taggable.tags << Tag.new( :name => rooms)
        end
        when 'room_types_1st_floor':
        taggable.name = 'Első emelet'
        taggable.context = 'Helyiségek elrendezése'
        taggable.multi = true
        taggable.position = 9
        ['nincs', 'nappali', '1 hálószoba', '2 hálószoba', '3 hálószoba', '4 hálószoba', 'étkező', 'nappali + étkező + konyha', 'konyha', 'konyha + étkező', 'WC', 'WC + fürdő', 'tusoló', 'WC + tusoló', 'erkély'].each do |rooms|
          taggable.tags << Tag.new( :name => rooms)
        end
        when 'room_types_2nd_floor':
        taggable.name = 'Második emelet'
        taggable.context = 'Helyiségek elrendezése'
        taggable.multi = true
        taggable.position = 10
        ['nincs', 'nappali', '1 hálószoba', '2 hálószoba', '3 hálószoba', '4 hálószoba', 'étkező', 'nappali + étkező + konyha', 'konyha', 'konyha + étkező', 'WC', 'WC + fürdő', 'tusoló', 'WC + tusoló', 'erkély'].each do |rooms|
          taggable.tags << Tag.new( :name => rooms)
        end
        when 'room_types_mansard':
        taggable.name = 'Tetőtér'
        taggable.context = 'Helyiségek elrendezése'
        taggable.multi = true
        taggable.position = 11
        ['nincs', 'nappali', '1 hálószoba', '2 hálószoba', '3 hálószoba', '4 hálószoba', 'étkező', 'nappali + étkező + konyha', 'konyha', 'konyha + étkező', 'WC', 'WC + fürdő', 'tusoló', 'WC + tusoló', 'erkély'].each do |rooms|
          taggable.tags << Tag.new( :name => rooms)
        end
        when 'owner_speaks':
        taggable.name = 'Háztulajdonos milyen nyelven beszél?'
        taggable.context = 'Háztulajdonos infók'
        taggable.multi = true
        taggable.position = 61
        ['magyar','német','angol','orosz', 'francia', 'olasz'].each do |language|
          taggable.tags << Tag.new( :name => language)
        end
        when 'category':
        taggable.name = 'Csoport'
        taggable.context = 'Ház alap infók'
        taggable.multi = true
        taggable.position = 80
        ['Medencés házak', 'Közvetlen vízparti', 'TOP 10', 'FKK', 'Megvásárolható', 'Termál', 'Horvátország'].each do |language|
          taggable.tags << Tag.new( :name => language)
        end
        end
        if taggable.save
        @result << field
        end
      end
      @result = @result.join(', ') + ' done'
    else
      @result = empties.join(', ') + '<br />What shold I do? <a href="?do=12">DO!</a>'
    end
  end

  def upload
  end
  
  def csv_import
    if params[:dump].nil?
      redirect_to :action =>:upload
    else
      @parsed_file=CSV::Reader.parse(params[:dump][:file], ';')
      n=0
      @lines = []
      @parsed_file.each do |row|
        line = row
        next if line[0] !~ /^[0-9\-\/]+/
        n+=1
        house = House.find_or_initialize_by_code(line[0])
        house.persons = line[1]
        house.children = line[2]
        taggable_id = Taggable.find_by_field('house_type_id')
        tags = Tag.find_all_by_taggable_id(taggable_id)
        name = case line[3]
        when 'Onallo haz':
          'Önálló ház'
        when 'hazresz':
          'Házrész'
        when 'Ikerhaz':
          'Ikerház'
        when 'apartmanhaz'
          'Apartmanház'
        end
        house.house_type_id = tags.select{|tag| tag.name == name}.first.id
        
        taggable_id = Taggable.find_by_field('condition_id')
        tags = Tag.find_all_by_taggable_id(taggable_id)
        name = case line[4]
        when 'felujitott':
          'Felújított'
        when 'hagyomanyos':
          'Hagyományos'
        end
        house.condition_id = tags.select{|tag| tag.name == name}.first.id
        
        taggable_id = Taggable.find_by_field('furnishing_id')
        tags = Tag.find_all_by_taggable_id(taggable_id)
        name = case line[5]
        when 'jo minosegu':
          'jó minőségű'
        when 'hagyomanyos':
          'hagyományos'
        when 'modern':
          'modern'
        end
        house.furnishing_id = tags.select{|tag| tag.name == name}.first.id
        house.city_id = Taggable.find_by_field('city_id').tags.first.id

        if house.save
          @lines << line[0]
        else
          @lines << house.errors.first.message
        end
      end
      data_error = ''
      flash.now[:message] = "CSV Import Successful, #{n} new records added to database.<br />params was = #{params.inspect}<br />#{data_error}"
    end
  end
end
