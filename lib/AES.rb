require 'openssl'
require 'base64'
require 'myhttp'
require 'pry'

class AES

  def self.get_json_by_post(url, key_in, data)
# AES/ECB/pkcs5padding 128
    cipher = OpenSSL::Cipher.new('aes-128-ecb')
    
# AES, block size = 128，使用 ECB
    cipher.encrypt
# 随机生成密钥
    key = cipher.key = key_in
# key = cipher.random_key
# 随机生成初始向量
    iv = cipher.iv = cipher.random_iv
    
    encrypted = cipher.update(data) + cipher.final
    
    encode = Base64.strict_encode64(encrypted)

    response = MyHttp.post(url,
    :body => encode,
    :headers => {
      'Content-Type' => 'application/json'
    # 'Referer' => 'http://music.baidu.com'
    })
    decode = Base64.strict_decode64(response)

    decipher = OpenSSL::Cipher.new('aes-128-ecb')
    decipher.decrypt
    decipher.key = key
    decipher.iv = iv
    plain = decipher.update(decode) + decipher.final
    
  end

  
  def self.get_json_by_post_without_encrypt(url, data)
    encode = Base64.strict_encode64(data)
    
    response = MyHttp.post(url, :body => encode,
    :headers => {
    'Content-Type' => 'application/json'
    })
    decode = Base64.strict_decode64(response)
  end


  def self.get_json_by_post_without_encode(url, data)
    response = MyHttp.post(url, :body =>data,
    :headers => {
    'Content-Type' => 'application/json'
    }).to_json
  end


end
