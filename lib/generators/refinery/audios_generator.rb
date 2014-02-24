module Refinery
  class AudiosGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    def rake_db
      rake 'refinery_audios:install:migrations'
      rake 'db:migrate'
    end

    def generate_videos_initializer
      template "config/initializers/refinery/audios.rb.erb", File.join(destination_root, "config", "initializers", "refinery", "audios.rb")
    end



    def generate_video_public
      template "public/video-js.swf", File.join(destination_root, "public", "video-js.swf")
      directory "public/font", File.join(destination_root, "public", "font")
    end


    def append_load_seed_data
      create_file 'db/seeds.rb' unless File.exists?(File.join(destination_root, 'db', 'seeds.rb'))
      append_file 'db/seeds.rb', :verbose => true do
        <<-EOH

# Added by Refinery CMS Audios extension
Refinery::Audios::Engine.load_seed
        EOH
      end
    end
  end
end
