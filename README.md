# Porxy Module by mod_mruby

Proxy Module using mod_mruby.

- mrbgem dependency for mod_mruby

    `Nothing`

## How to Use
- Intall mod_mruby previously

    See https://github.com/matsumoto-r/mod_mruby

- Copy conf

    ```bash
    cp mod_mruby_proxy.conf ${HTTPD_ROOT}/conf.d/.
    ```

- Change mod_mruby_proxy.conf for you

    ```apache
    <IfModule mruby_module>
      # simple proxy module
      mrubyTranslateNameFirst /path/to/proxy.rb
      
      # proxy modul by scoreboard information
      #mrubyTranslateNameFirst /path/to/proxy_by_scboard.rb
    </IfModule>
    ```

- Change /path/to/proxy_by_scboard.rb for you

    ```ruby
    backends = [
        "http://192.168.0.101:8888/",
        "http://192.168.0.102:8888/",
        "http://192.168.0.103:8888/",
        "http://192.168.0.104:8888/",
    ]
    
    # この辺に色々条件を入れたり、backends配列から取り出すルールを別途定義したりするとmod_mrubyのうまみがでる？
    
    r = Apache::Request.new
    
    r.handler  = "proxy-server"
    r.proxyreq = Apache::PROXYREQ_REVERSE
    r.filename = "proxy:" + backends[rand(backends.length)] + r.uri
    
    Apache.return Apache::OK
    ```

- httpd restart

    ```bash
    service httpd restart
    ```
