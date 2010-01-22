#!/urs/bin/ruby

langs = {}
count = 0
%w{hu de}.each do |lang|
  langs[lang] = open(lang+'.yml').readlines.map { |line| line.split(': ',2) }
  if langs[lang].size > count
    count = langs[lang].size
  end
end
(0..count).each do |i|
  %w{hu de}.each do |lang|
    unless langs[lang][i].nil?
      if lang == 'hu'
        print langs[lang][i][0].rstrip
      end
      print "\t" + langs[lang][i][1].strip if langs[lang][i][1]
    end
  end
  print "\n"
end
