require 'pry'

class Features

  def self.get_create(file, params)
    file_backup(file)
    featureFile = File.open(file,"a+")

      id = params[:id]
      result = params[:result]

      if params[:url].include? "http"
        url = params[:url]
      else
        url = "http://#{params[:url]}"
      end
      
      featureFile.puts "      |#{id}|#{url}|#{result}|"

    featureFile.close
  end

  def self.get_destroy(file, params)
    file_backup(file)
    id = params[:id]
    `sed -i '/|#{id}|/d' #{file}`
  end

  def self.file_backup(file)
    time = Time.now.strftime("%Y%m%d%H%M%S")
    FileUtils.cp file, "#{file}_#{time}.bak"
  end
end
