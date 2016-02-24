# language: zh-CN

功能: Post请求获取json数据

#背景:

  场景大纲: Post方法请求json数据
    假如运行的用例的标题为"<title>"
    同时发送一个<project>项目<parameter>参数<data>数据的post方法的请求到服务器端口
    那么返回的post数据应该包含:
      | <result0> |
      | <result1> |
      | <result2> |
      | <result3> |
      | <result4> |
      | <result5> |
      | <result6> |
      | <result7> |
      | <result8> |
      | <result9> |

    例子:
      | id | title  | project | parameter | data | result0 |result1|result2|result3|result4|result5|result6|result7|result8|result9|
      |4|123|1|/standalone/getGameRecommendV140|{"tag":"45","packageName_list":["com.baidu.appsearch","com.cleanmaster.mguard_cn"],"screen_orientation":"0","gameversion":"1.4.2","px_version":"1.0.0","gameversioncode":"142","gamepackagename":"com.duoku.platform.demo.single","version":"2.0.0","ua":"Nexus 5","os":"android","connecttype":"wifi","screenwh":"1794_1080","channel":"13744,","imei":"359250052307939","udid":"A4353E261951B1A504C22CF18876FA7F","appid":"4110","appkey":"b80b8ecead42c8678537d282096df15c","app_secret":"828e3bd4c3c9903cbde222e2d6e51920","location":"40.0276512_116.3084941","bdcuid":"79B365380C3780A7FF42BE4284EE68C8\|939703250052953","bdpushid":"933648745878021527"}|"game_id": "30167"||||||||||
