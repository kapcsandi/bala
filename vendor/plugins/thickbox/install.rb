require 'fileutils'

loading_gif       = File.dirname(__FILE__) + '/../../../public/images/loading.gif'
jquery_js         = File.dirname(__FILE__) + '/../../../public/javascripts/jquery.js'
jquery_pack_js    = File.dirname(__FILE__) + '/../../../public/javascripts/jquery.pack.js'
thickbox_js       = File.dirname(__FILE__) + '/../../../public/javascripts/thickbox.js'
thickbox_pack_js  = File.dirname(__FILE__) + '/../../../public/javascripts/thickbox.pack.js'
thickbox_css      = File.dirname(__FILE__) + '/../../../public/stylesheets/thickbox.css'

FileUtils.cp File.dirname(__FILE__) + '/public/images/loading.gif',           loading_gif       unless File.exist?(loading_gif)
FileUtils.cp File.dirname(__FILE__) + '/public/javascripts/jquery.js',        jquery_js         unless File.exist?(jquery_js)
FileUtils.cp File.dirname(__FILE__) + '/public/javascripts/jquery.pack.js',   jquery_pack_js    unless File.exist?(jquery_pack_js)
FileUtils.cp File.dirname(__FILE__) + '/public/javascripts/thickbox.js',      thickbox_js       unless File.exist?(thickbox_js)
FileUtils.cp File.dirname(__FILE__) + '/public/javascripts/thickbox.pack.js', thickbox_pack_js  unless File.exist?(thickbox_pack_js)
FileUtils.cp File.dirname(__FILE__) + '/public/stylesheets/thickbox.css',     thickbox_css      unless File.exist?(thickbox_css)

puts IO.read(File.join(File.dirname(__FILE__), 'README'))