backends = [
    "http://192.168.0.101:8888/",
    "http://192.168.0.102:8888/",
    "http://192.168.0.103:8888/",
    "http://192.168.0.104:8888/",
]
 
# �����դ˿����������줿�ꡢbackends���󤫤���Ф��롼���������������ꤹ���mod_mruby�Τ��ޤߤ��Ǥ롩
 
r = Apache::Request.new
 
r.handler  = "proxy-server"
r.proxyreq = Apache::PROXYREQ_REVERSE
r.filename = "proxy:" + backends[rand(backends.length)] + r.uri
 
Apache.return Apache::OK
