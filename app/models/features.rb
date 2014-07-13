require 'pry'

class Features

  def self.get_create(file, params)
    file_backup(file)
    featureFile = File.open(file,"a+")

      id = params[:id]
      lines = params[:result]
      array1 = lines.chomp.split("\r\n")
      result = []
      0.upto(array1.length-1) {|x| result[x] = array1[x]}

      if params[:url].include? "http"
        url = params[:url]
      else
        url = "http://#{params[:url]}"
      end
      
      featureFile.puts "      |#{id}|#{url}|#{result[0]}|#{result[1]}|#{result[2]}|#{result[3]}|#{result[4]}|#{result[5]}|#{result[6]}|#{result[7]}|#{result[8]}|#{result[9]}|"

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
