#!/urs/bin/ruby

langs = ['hu', 'de']
count = 0
dict = open('dict.csv').readlines
langs.each_with_index do |lang,index|
  f=open(lang+'.yml','w+')
  dict.each do |line|
    items = line.split("\t")
    items = (items.size > 1 ? (items[index+1] ? items.values_at(0,index+1).join(': ') : items.values_at(0,1).join(': ')) : items[0] )
    f.puts items
  end
  f.close
end
