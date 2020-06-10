# Serveur settings
set("harbor.bind_addr","0.0.0.0")
set("server.telnet", true)
set("server.telnet.port", 2424)
set("server.telnet.bind_addr","0.0.0.0")

set("harbor.verbose",true)


# An emergency file
emergency = single("/home/lolz/music/main/intro.mp3")

# A playlist
rock = playlist("/home/lolz/music/rock/")
sad = playlist("/home/lolz/music/sad/")
#dub = playlist("/home/lolz/music/dub/")
#lofi = playlist("/home/lolz/music/lofi/")


# A live source
live = input.harbor(user="test","live",port=8005,password="test")

# fallback
radio = fallback(track_sensitive=false,
                 [live,rock,emergency])

radio2 = fallback(track_sensitive=false,
                 [live,sad,emergency])


# output it
output.icecast(%mp3(bitrate=320),icy_metadata="true",
  host = "localhost", port = 8000,
  password = "password", mount = "/rock", radio)


# output it
output.icecast(%mp3(bitrate=320),icy_metadata="true",
  host = "localhost", port = 8000,
  password = "password", mount = "/sad", radio2)


