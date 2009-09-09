require 'open-uri'

namespace :extjs do
  version = "3.0.0"
    
  task :download do
    unless File.exist?("#{RAILS_ROOT}/public/javascripts/ext3/ext-all.js")
      zip_name = "ext-#{version}.zip"
      unzipped_folder_name = "ext-#{version}"
      Dir.chdir("#{RAILS_ROOT}/vendor") do
        url = "http://extjs.cachefly.net/ext-3.0.0.zip"
        puts "Downloading ExtJS #{version}"
        open(zip_name, 'w').write(open(url).read)
        done = false
        while !done
          sleep 1
          done = File.exists?(zip_name) && File.size(zip_name) > (9.megabytes + 800.kilobytes) 
        end  
        puts "Donwload complete! "
      end
    end # unless
  end # task

  task :unzip do
    unless File.exist?("#{RAILS_ROOT}/public/javascripts/ext3/ext-all.js")
      zip_name = "ext-#{version}.zip"
      unzipped_folder_name = "ext-#{version}"
      Dir.chdir("#{RAILS_ROOT}/vendor") do
        system "unzip #{zip_name}"
        system "mv #{unzipped_folder_name} ext3"
        system "rm #{zip_name}"        
      end
    end # unless
  end # task
        
end # namespace