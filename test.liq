# Serveur settings
set("harbor.bind_addr","0.0.0.0")

set("harbor.verbose",true)


# An emergency file
emergency = single("/home/lolz/music/main/emergency.mp3")

# A playlist
playlist = playlist("/home/lolz/music/main/")

# A live source
live = input.harbor(user="test","live",port=8005,password="test")

# fallback
radio = fallback(track_sensitive=false,
                 [live,playlist,emergency])

# output it
output.icecast(%mp3(bitrate=320),icy_metadata="true",
  host = "localhost", port = 8000,
  password = "supersecret69!", mount = "/source",
  radio)
