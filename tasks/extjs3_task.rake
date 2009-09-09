namespace :extjs3 do
  version = "3.0.0"

  # Target folder layout
  #
  # + public
  #   + javascripts
  #     + ext3
  #       + adapters
  #        - base, prototype, jquery, yui
  #       + pkgs (optional)
  #       - core files
  #   + resources
  #     - swf files
  #     + css      
  task :install do    
    public_dir = "#{RAILS_ROOT}/public/"  
    ext_target_dir = File.join public_dir, "javascripts/ext3"
    FileUtils.mkdir ext_target_dir unless File.exists?(ext_target_dir)

    Dir.chdir("#{RAILS_ROOT}/vendor/ext3") do

      # always copy core (in root of ext)
      puts "Installing core .js files"      
      js_files = Dir.glob('ext-all-*.js')
      js_files.each do |file|
          FileUtils.copy(file, ext_target_dir)
      end

      # copy packages      
      unless ENV.include?("no-pkg")
        puts "Installing packages"              
        ext_pkg_dir = File.join(ext_target_dir, "pkgs")
        FileUtils.cp_r("pkgs", ext_pkg_dir) 
      end

      # create target dir for ext3 resources
      resources_target_dir = File.join(public_dir, "ext3")

      # copy resources
        puts "Installing resources"                    
      FileUtils.cp_r("resources", resources_target_dir)   
          
    end # ext3        
  end # task  
  
  task :adapters do
    if ENV.include?("adapter") 
      unless (ENV['adapter']=='jquery' || ENV['adapter']=='prototype' || ENV['adapter']=='yui')
        raise "usage: rake adapter=xxx extjs:copy # valid adapters are [jquery], [prototype], [yui], default with no argument is to install all adapters" 
      end
    end

    formats = []
    if ENV['adapter']
      format = ENV['adapter']
      formats = [format]
    else
      formats = ["prototype", "jquery", "yui"]
    end
  
    public_dir = "#{RAILS_ROOT}/public/"  
    ext_target_dir = File.join public_dir, "javascripts/ext3"
    FileUtils.mkdir ext_target_dir unless File.exists?(ext_target_dir)

    # create adapter dir
    adapter_target_dir = File.join(ext_target_dir, "adapter")
    FileUtils.mkdir(adapter_target_dir) unless File.exists?(adapter_target_dir)

    Dir.chdir("#{RAILS_ROOT}/vendor/ext3/adapter") do
    
      puts formats
    
      # always copy base
      Dir.chdir("ext") do
        puts "Installing base adapter"        
        js_files = Dir.glob('*.js')
        js_files.each do |file|
          FileUtils.copy(file, adapter_target_dir)
        end                    
      end

      if formats.include?("jquery")
        puts "Installing jquery adapter"
        Dir.chdir("jquery") do
          js_files = Dir.glob('*.js')
          js_files.each do |file|
            FileUtils.copy(file, adapter_target_dir)
          end                    
        end              
      end
      
      if formats.include?("prototype")
        puts "Installing prototype adapter"
        Dir.chdir("prototype") do
          js_files = Dir.glob('*.js')
          js_files.each do |file|
            FileUtils.copy(file, adapter_target_dir)
          end                    
        end              
      end # proto
      
      if formats.include?("yui")
        puts "Installing yui adapter"        
        Dir.chdir("yui") do
          js_files = Dir.glob('*.js')
          js_files.each do |file|
            FileUtils.copy(file, adapter_target_dir)
          end                    
        end              
      end # yui 
    end # adapter   
  end # task
end