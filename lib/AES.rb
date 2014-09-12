require 'openssl'
require 'base64'
require 'myhttp'
require 'pry'

class AES

	def self.get_json_by_post
    data = '{"os":"android","tag":"44","gameversion":"1.2.1.9","imei":"866324013445397","appkey":"7afce403f1a8146b8e425b944e7b59bb","appid":"3947","udid":"317415E1B29535B4F4C6655E1665DA45","version":"1.3.0","gamepackagename":"com.duoku.platform.demo.single","screenwh":"480_854","connecttype":"wifi","ua":"Coolpad 7290","app_secret":"642a8d684f8b601bd5a090394b2806c3","px_version":"1.0.0","channel":"3947","gameversioncode":"1219"}'
    cipher = OpenSSL::Cipher.new('aes-128-ecb')
    
    # AES, block size = 128，使用 CBC
    cipher.encrypt
    # 随机生成密钥
    key = cipher.key = 'AKlMU89D3FchIkhK'
    #key = cipher.random_key
    # 随机生成初始向量
    iv = cipher.iv = cipher.random_iv
    #cipher.iv = nil
    
    encrypted = cipher.update(data) + cipher.final
    
    encode = Base64.strict_encode64(encrypted)

wo = MyHttp.post("http://10.10.0.147:8082/standalone/getGameRecommend",
    :body => encode,
		:headers => {
			'Content-Type' => 'application/json',
		#	'Referer' => 'http://music.baidu.com'
		})
    decode = Base64.strict_decode64(wo)

    decipher = OpenSSL::Cipher.new('aes-128-ecb')
    decipher.decrypt
    decipher.key = key
    decipher.iv = iv
    plain = decipher.update(decode) + decipher.final
    
	end
end
