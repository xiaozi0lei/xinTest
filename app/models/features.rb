require 'pry'

class Features

  # 先备份，然后将数据插入到cucumber文件中
  # file - 要备份的文件，也是要插入数据的file
  # params - get 或 post方法的传进来的页面参数
  def self.get_create(file, params)
    # 备份原始文件
    file_backup(file)
    # 往文件中写新数据
    featureFile = File.open(file,"a+")
  
      # 用例ID
      id = params[:id]
      # 将用例中的期望结果处理一下，去掉换行符和空行
      lines = params[:result]
      array1 = lines.chomp.split("\r\n")
      result = []
      0.upto(array1.length-1) {|x| result[x] = array1[x]}
  
      # 处理url前面不带http的url，加上http://
      if params[:url].include? "http"
        url = params[:url]
      else
        url = "http://#{params[:url]}"
      end
      
      # 往文件中写入新的数据
      featureFile.puts "      |#{id}|#{url}|#{result[0]}|#{result[1]}|#{result[2]}|#{result[3]}|#{result[4]}|#{result[5]}|#{result[6]}|#{result[7]}|#{result[8]}|#{result[9]}|"
  
    # 写完后关闭文件
    featureFile.close
  end
  
    def self.post_create(file, params)
    # 备份原始文件
    file_backup(file)
    # 往文件中写新数据
    featureFile = File.open(file,"a+")
  
      # 用例ID
      id = params[:id]
      # project
      project = params[:project]
      # 处理url前面不带http的url，加上http://
      if params[:url].include? "http"
        url = params[:url]
      else
        url = "http://#{params[:url]}"
      end
      # data
      data = params[:data]
      # 将用例中的期望结果处理一下，去掉换行符和空行
      lines = params[:result]
      array1 = lines.chomp.split("\r\n")
      result = []
      0.upto(array1.length-1) {|x| result[x] = array1[x]}
  
      
      # 往文件中写入新的数据
      featureFile.puts "      |#{id}|#{project}|#{url}|#{data}|#{result[0]}|#{result[1]}|#{result[2]}|#{result[3]}|#{result[4]}|#{result[5]}|#{result[6]}|#{result[7]}|#{result[8]}|#{result[9]}|"
  
    # 写完后关闭文件
    featureFile.close
  end
  
  
  # 删除文件中对应的用例
  def self.destroy(file, params)
    # 先备份文件
    file_backup(file)
    # 根据ID获取文件对应行数
    id = params[:id]
    # 删除文件中对应的用例
    `sed -i '/|#{id}|/d' #{file}`
  end
  
  # 备份文件方法
  def self.file_backup(file)
    # 获取当前时间作为文件名的一部分
    time = Time.now.strftime("%Y%m%d%H%M%S")
    # cp源文件为带时间戳的新文件
    FileUtils.cp file, "#{file}_#{time}.bak"
  end
end
