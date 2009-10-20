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
        %w(Balatonlelle Balatonboglár).each do |city|
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
        ['nincs', 'fedett', 'nyitott'].each do |terrace|
          taggable.tags << Tag.new( :name => terrace)
        end
        when 'balcony_id':
        taggable.name = 'Erkély'
        taggable.context = 'Helyiségek'
        taggable.multi = false
        taggable.position = 18
        ['nincs', 'fedett', 'nyitott', '2' ].each do |terrace|
          taggable.tags << Tag.new( :name => terrace)
        end
        when 'stove_id':
        taggable.name = 'Tűzhely'
        taggable.context = 'Konyha'
        taggable.multi = false
        taggable.position = 42
        ['elektromos tűzhely', 'gáz', 'gáz + PB', 'főzőlap', 'gázfőzőlap'].each do |stove|
          taggable.tags << Tag.new( :name => stove)
        end
        when 'clima_id':
        taggable.name = 'Klíma'
        taggable.context = 'Egyéb belső felszereltség'
        taggable.multi = false
        taggable.position = 45
        ['nincs', 'egész terület', 'földszint', 'emelet', 'mobil klíma'].each do |clima|
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
        ['nincs', 'nappali', '1 hálószoba', '2 hálószoba', '3 hálószoba', '4 hálószoba', 'étkező', 'nappali + étkező', 'nappali + étkező + konyha', 'konyha', 'konyha + étkező', 'WC', 'fürdőszoba + WC', 'tusoló', 'WC + tusoló', 'terasz', 'kertkapcsolat'].each do |rooms|
#          taggable.tags << Tag.new( :name => rooms)
        end
        when 'room_types_1st_floor':
        taggable.name = 'Első emelet'
        taggable.context = 'Helyiségek elrendezése'
        taggable.multi = true
        taggable.position = 9
        ['nincs', 'nappali', '1 hálószoba', '2 hálószoba', '3 hálószoba', '4 hálószoba', 'étkező', 'nappali + étkező',  'nappali + étkező + konyha', 'konyha', 'konyha + étkező', 'WC', 'fürdőszoba + WC', 'tusoló', 'WC + tusoló', 'erkély'].each do |rooms|
#          taggable.tags << Tag.new( :name => rooms)
        end
        when 'room_types_2nd_floor':
        taggable.name = 'Második emelet'
        taggable.context = 'Helyiségek elrendezése'
        taggable.multi = true
        taggable.position = 10
        ['nincs', 'nappali', '1 hálószoba', '2 hálószoba', '3 hálószoba', '4 hálószoba', 'étkező', 'nappali + étkező',  'nappali + étkező + konyha', 'konyha', 'konyha + étkező', 'WC', 'fürdőszoba + WC', 'tusoló', 'WC + tusoló', 'erkély'].each do |rooms|
#          taggable.tags << Tag.new( :name => rooms)
        end
        when 'room_types_mansard':
        taggable.name = 'Tetőtér'
        taggable.context = 'Helyiségek elrendezése'
        taggable.multi = true
        taggable.position = 11
        ['nincs', 'nappali', '1 hálószoba', '2 hálószoba', '3 hálószoba', '4 hálószoba', 'étkező', 'nappali + étkező',  'nappali + étkező + konyha', 'konyha', 'konyha + étkező', 'WC', 'fürdőszoba + WC', 'tusoló', 'WC + tusoló', 'erkély'].each do |rooms|
#          taggable.tags << Tag.new( :name => rooms)
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
#	begin
        line = row
        next if line[0] !~ /^[0-9\-\/]+/
        house = House.find_or_initialize_by_code(line[0]) # A => code, Kód
	house.tags.build
	cities = Taggable.find_by_field('city_id').tags
        house.city_id = case house.code
	when /^25/
	  cities.find_by_name('Balatonlelle').id
	when /^24/
	  cities.find_by_name('Balatonboglár').id
	end # Település 24 => Balatonboglár, 25 => Balatonlelle
        house.persons = line[1] # B => persons, Maximum felnőtt fő
        house.children = line[2] # C => children, Maximum gyerek fő
        taggable_id = Taggable.find_by_field('house_type_id')
        tags = Tag.find_all_by_taggable_id(taggable_id)
        name = case line[3]
        when 'Onallo haz':
          'Önálló ház'
        when 'hazresz':
          'Házrész'
        when 'Ikerhaz':
          'Ikerház'
        when /apar/
          'Apartmanház'
        end
        house.house_type_id = tags.select{|tag| tag.name == name}.first.id # D => house_type_id, Apartman típusa
        
        taggable_id = Taggable.find_by_field('condition_id')
        tags = Tag.find_all_by_taggable_id(taggable_id)
        name = case line[4]
        when 'felujitott':
          'Felújított'
        when 'hagyomanyos':
          'Hagyományos'
	when 'uj epitesu':
	  'Új építésű'
        end
        house.condition_id = tags.select{|tag| tag.name == name}.first.id # E => condition_id, Állapot
        
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
        house.furnishing_id = tags.select{|tag| tag.name == name}.first.id # F => furnishing_id, Berendezés

	# G => fekvés
	taggable = Taggable.find_by_field('accomodation')
        names = line[6].split(',').map do |name|
	  case name
	  when /csendes/
	    'csendes'
	  when /utcara/
	    'utcára néző'
	  when /kertre/
	    'kertre néző'
	  when /kozvetlen/
	    'közvetlen vízparti'
	  when /fout/
	    'főút mellett'
	  end
	end
	house.tags << taggable.tags.select{|t| names.include?(t.name)}
	house.floor_area = line[7].to_i # H => floor_area, Alapterület (négyzetméter)
	# I => Helyiségek elrendezése, földszint
	# J, K, L => Helyiségek elrendezése, 1. emelet, 2. emelet, tetőtér
	taggables = Taggable.find_all_by_position([8, 9, 10, 11])
	taggables.each_with_index do |taggable,index|
	  if line[index+8]
	    names = line[index+8].split(',').map do |name|
	      name = name.downcase.strip.gsub(/[\ ]?\+[\ ]?/, ' + ').gsub(/etkezo/,'étkező').gsub(
		/alo/,'áló').gsub(/urdo/,'ürdő').gsub(/olo/, 'oló').gsub(/nyzo/,'nyzó').gsub(
		  /kely/,'kély')
	      atag = taggable.tags.find_by_name(name)
	      unless atag
		taggable.tags << Tag.new(:name => name)
		taggable.save!
	      end
	      name
	    end
	  else
	    names =  ["nincs"]
	  end
	  house.tags << taggable.tags.select{|t| names.include?(t.name)}
	end
	# M => Helyiségek, Nappali + étkező
	house.living_dining_room = line[12].to_i
	# N => Helyiségek, Hálószoba
	house.bedroom = line[13].to_i
	# O => Helyiségek, Nappali
	house.living_room = line[14].to_i
	# P => Helyiségek, Nappali + étkező + konyha
	house.living_dining_kitchen = line[15].to_i
	# Q => Helyiségek, Konyha
	house.kitchen = line[16].to_i
	# R => Helyiségek, Étkező
	house.dining_room = line[17].to_i
	# S => Helyiségek, Étkező + konyha
	house.kitchen_dining_room = line[18].to_i
	# T => Helyiségek, Terasz
	taggable_id = Taggable.find_by_field('terrace_id')
        tags = Tag.find_all_by_taggable_id(taggable_id)
        name = line[19].strip.downcase
	tag = tags.select{|tag| tag.name == name}.first
	if tag
	  house.terrace_id = tag.id
	else
	  @lines << "HIBA terrace_id"
	  @lines << name.inspect
	end
	# U => Helyiségek, Erkély
	taggable_id = Taggable.find_by_field('balcony_id')
        tags = Tag.find_all_by_taggable_id(taggable_id)
        name = line[20].strip.downcase
        house.balcony_id = tags.select{|tag| tag.name == name}.first.id
	# V => Helyiségek, Kertkapcsolat
	house.garden = line[21] =~ /igen/ ? 1 : 0
	# W => Helyiségek alapterülete, nappali
	house.living_room_sq = line[22].to_i
	# X => Helyiségek alapterülete, nappali + étkező
	house.living_dining_room_sq = line[23].to_i
	# Y => Helyiségek alapterülete, nappali + étkező + konyha
	house.living_dining_kitchen_sq = line[24].to_i
	# Z - AE => Helyiségek alapterülete
	house.kitchen_sq = line[25].to_i
	house.dining_room_sq = line[26].to_i
	house.kitchen_dining_room_sq = line[27].to_i
	house.terrace_sq = line[28]
	house.balcony_sq = line[29]
	house.yard_sq = line[30]
	# AF - AI => Ágyak
	house.double_bed = line[31].to_i
	house.single_bed = line[32]
	house.extra_bed = line[33].to_i
	house.pull_out_bed = line[34].to_i
	# AJ - AL => Fürdőszoba
	house.bathrooms = line[35].to_i
	house.shower = line[36].to_i
	house.bathtub = line[37].to_i
	# AM - AN => WC
	house.wcs = line[38].to_i
	house.wc_separated = line[39].to_i
	# AO - AR => Konyha
	house.fridge = line[40].to_i
	house.coffee_machine = line[41].to_i
	house.micro = line[42].to_i
	taggable_id = Taggable.find_by_field('stove_id')
        tags = Tag.find_all_by_taggable_id(taggable_id)
	name = case line[43]
        when 'gaz':
          'gáz'
        when 'fozolap':
          'főzőlap'
        when /elektromos/:
          'elektromos tűzhely'
	when 'gaz+PB':
	  'gáz + PB'
	when 'gazfozolap'
	  'gázfőzőlap'
        end
	tag = tags.select{|tag| tag.name == name}.first
	if tag
	  house.stove_id = tag.id
	else
	  @lines << "HIBA stove_id"
	  @lines << name.inspect
	end
	# AS - AU => Egyéb belső felszereltség
	house.sat = line[44].to_i
	house.internet = line[45] =~ /igen/ ? 1 : 0
	taggable_id = Taggable.find_by_field('clima_id')
        tags = Tag.find_all_by_taggable_id(taggable_id)
	name = case line[46]
        when /egesz/:
          'egész terület'
        when 'emelet':
          'emelet'
        when /foldsz/:
          'földszint'
	when 'nincs':
	  'nincs'
	when 'mobilklima':
	  'mobil klíma'
        end
	tag = tags.select{|tag| tag.name == name}.first
	if tag
	  house.clima_id = tag.id
	else
	  @lines << "HIBA clima_id"
	  @lines << name.inspect
	end
	# AV - BB => Egyéb külső felszereltség
	house.pool = line[47] =~ /igen/ ? 1 : 0
	house.pool_sq = line[48].to_i
	house.garden_seats = line[49] =~ /igen/ ? 1 : 0
	house.grill = line[50] =~ /igen/ ? 1 : 0
	house.sunbath_seat = line[51] =~ /igen/ ? 1 : 0
	house.playground = line[52] =~ /igen/ ? 1 : 0
	taggable_id = Taggable.find_by_field('parking_id')
        tags = Tag.find_all_by_taggable_id(taggable_id)
	name = case line[53]
        when /zart/:
          'zárt'
	else
	  line[53]
        end
#	['zárt', 'zárt + garázs', 'utca', 'garázs', 'udvarban']
        house.parking_id = tags.select{|tag| tag.name == name}.first.id
	# BC - BJ => Távolságok
	house.distance_center = line[54].to_i
	house.distance_beach = line[55].to_i
	house.distance_aquapark = line[56].to_i
	house.distance_shop = line[57].to_i
	house.distance_station = line[58].to_i
	house.distance_medical = line[59].to_i
	house.distance_mainroad = line[60].to_i
	house.distance_restaurant = line[61].to_i
	# BK - BL => Háztulaj infók
	taggable = Taggable.find_by_field('owner_speaks')
	names = line[62].split(',').map do |name|
	  name = name.downcase.strip.gsub(/nemet/,'német').gsub(/.*agya.*/,'magyar')
	  atag = taggable.tags.find_by_name(name)
	  unless atag
	  taggable.tags << Tag.new(:name => name)
	  taggable.save!
	  name
	  end
	end
	house.tags << taggable.tags.select{|t| names.include?(t.name)}
	taggable_id = Taggable.find_by_field('owner_place_id')
        tags = Tag.find_all_by_taggable_id(taggable_id)
	name = case line[63]
        when /kulon/:
          'külön épületben, szeparáltan'
	when /az/:
	  'az épületben, szeparáltan'
	when /nem/:
	  'nem lakik ott'
	else
	  nil
        end
#	   ['külön épületben, szeparáltan', 'az épületben, szeparáltan', 'nem lakik ott']
	tag = tags.select{|tag| tag.name == name}.first 
	if tag
	  house.owner_place_id = tag.id
	else
	  @lines << "HIBA owner_place_id"
	  @lines << name.inspect
	end
	house.animals = line[64] =~ /igen/ ? 1 : 0
	house.animal_charge = line[65] =~ /igen/ ? 1 : 0
	house.price_pre_season_per_day = line[66].to_s.gsub(/,/,'.').to_f
	house.price_mid_season_per_day = line[67].to_s.gsub(/,/,'.').to_f
	house.price_main_season_per_day = line[68].to_s.gsub(/,/,'.').to_f
	house.price_pre_season_per_week = line[70].to_s.gsub(/,/,'.').to_f
	house.price_mid_season_per_week = line[71].to_s.gsub(/,/,'.').to_f
	house.price_main_season_per_week = line[72].to_s.gsub(/,/,'.').to_f
	unless line[74].nil?
	  house.discount = Discount.new(:description => line[73])
	end
	house.house_description = line[75].to_s
	house.admin_description = line[76].to_s
        if house.save
	  n+=1
          @lines << line[0]
	  @lines << names
        else
          @lines << house.errors.first.message
        end
#	rescue => ex
#	  @lines << "#{ex.backtrace}: #{ex.message} (#{ex.class})"
#	  @lines << tags.map.inspect
#	  @lines << line.inspect
#	  @lines << names.inspect
#	end
      end
      data_error = ''
      flash.now[:message] = "CSV Import Successful, #{n} new records added to database.<br />params was = #{params.inspect}<br />#{data_error}"
    end
  end
end
