# encoding: UTF-8

require 'fileutils'

module WalterBishop
  class Bubbles
    def move_finished_episodes
      # Environment
      ORIGIN_PATH = '/Users/albert/Downloads/Series'
      DESTINY_PATH = '/Volumes/TimeCapsule'

      # Lib

      # Do nothing if empty
      if Dir[ORIGIN_PATH + "/*"].empty?
        puts "Nothing to do!"
        exit
      end

      # Mount Time Capsule if not mounted
      action_with_feedback 'Mounting Time Capsule' do
        unless File.exists?(DESTINY_PATH)
          `mkdir #{DESTINY_PATH}`
          `mount_afp "afp://@192.168.1.128/Time Capsule de Albert Bell" #{DESTINY_PATH}`
        end
      end

      # Navigate through all files and move them
      EPISODE_REGEXP = /(?<title>.+)\.(?<season>\d+)x(?<number>\d+)\.(?<extension>mkv|avi|mpge?g|srt)$/
      PROTECTED_DIR = /^(\.+)$/

      Dir.foreach(ORIGIN_PATH) do |file|
        # Evaluate if it is a correct file
        next unless match = EPISODE_REGEXP.match(file)
        file_path = ORIGIN_PATH + "/" + file
        title = match[:title].gsub('.', ' ')
        season = match[:season]
        number = match[:number]
        type = (match[:extension] == 'srt') ? "subtitles" : "video"
        nice_name = "#{title} #{season}x#{number} (#{type})"

        action_with_feedback "Placing #{nice_name}", -1 do
          # Check if the TV series' folder exists
          series_dir = DESTINY_PATH + "/Series"
          unless FileTest::directory?(series_dir)
            action_with_feedback "Creating a folder for series", 1 do
              Dir::mkdir(series_dir)
            end
          end

          # Check if this TV series' folder exists
          this_tv_series_dir = series_dir + "/" + title
          unless FileTest::directory?(this_tv_series_dir)
            action_with_feedback "Creating a folder for #{title}", 1 do
              Dir::mkdir(this_tv_series_dir)
            end
          end

          # Check the folder
          files = Dir.glob(this_tv_series_dir + "/*")
          if files.any?
            # Check if splitted into seasons or not
            video_files = Dir.glob(this_tv_series_dir + "/*.mkv") + Dir.glob(this_tv_series_dir + "/*.srt")
            moved_files = if video_files.any?
              current_season = video_files.first.split('.')[-2].split('x').first
              if current_season.to_i != season.to_i
                # Move files into its own season
                current_season_path = create_season_dir(this_tv_series_dir, current_season)
                action_with_feedback "Reorganizing previous files", 1 do
                  video_files.each { |mkv_file| `mv "#{mkv_file}" "#{current_season_path}"` }
                end
                true
              end
            end

            if video_files.empty? || moved_files
              this_season_path = create_season_dir(this_tv_series_dir, season.to_i)
            end
          end

          # Finally, transfer the file
          action_with_feedback "Transferring file", 1 do
            final_path = (this_season_path ||= nil) || this_tv_series_dir
            final_url = "#{final_path}/#{file}"

            FileUtils.mv(file_path, final_url)
          end
        end
      end
    end

    private

    def action_with_feedback(message, tabs = 0, &block)
      tabs_space = tabs.times.map { "\t" }.join
      print "#{tabs_space}#{message}... "
      print "\n" if tabs < 0

      block.call

      print "OK\n" unless tabs < 0
    end

    def create_season_dir(tv_series_path, season)
      this_season_dir = tv_series_path + "/#{season.to_i}ª temporada"
      unless FileTest::directory?(this_season_dir)
        action_with_feedback "Creating a folder for season #{season.to_i}", 1 do
          Dir::mkdir(this_season_dir)
        end
      end

      this_season_dir
    end
  end
end
