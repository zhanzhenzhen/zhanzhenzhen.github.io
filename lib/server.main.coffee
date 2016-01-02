server = require "site/server"
shared = require "site/shared"
fsMod = require "fs"
server.onRequest (ctx) ->
    host = ctx.request.host
    path = ctx.request.path
    response = ctx.response
    if host.is "www.zhanzhenzhen.com"
        response.redirectHost "zhanzhenzhen.com"
    else if path.is("/") or path.raw.indexOf(".") == -1
        response.handleHome()
    else
        response.handleFile()
server.host =
    if shared.isDebug()
        "127.0.0.1"
    else
        undefined
server.httpPort = 50003
server.httpsPort = 50004
server.httpEnabled =
    if shared.isDebug()
        false
    else
        true
server.httpsEnabled = true
server.httpsCredential =
    pfx: fsMod.readFileSync "credential.p12"
server.maxRequestBodySize = 65536
server.homePageAfterScript = """
    <script><![CDATA[
        (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
        (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
        m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
        })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
        ga('create', 'UA-19880790-4', 'auto');
        ga('send', 'pageview');
    ]]></script>
"""
server.start()
