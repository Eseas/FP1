# notakto

# Work plan
1. Check requirements.
    1. Use any package
1. GET/POST requests in Haskell
1. Find partner.
W
1. Test telnet: is it single move passing or all moves? - ALL
1. ToJSON - recursive Move with Points
1. Modify solve to add new move
1. pagrindine funcikja su argumentais: host url myid

# Risks and their management
1. Check used modules with lecturer.

Atom and haskell setup: https://github.com/simonmichael/haskell-atom-setup

Test solution: https://stackoverflow.com/a/43264723

# It does not
* detect, if same playerID makes two turns twice.

# HTTP
telnet tictactoe.haskell.lt 80

# 1
POST /game/yolo80/player/1 HTTP/1.1
Host: tictactoe.haskell.lt:80
Content-Type: application/json+map
Content-Length: 49

{"c": {"0": 0, "1": 0}, "v": "x", "id": "Ljuss1"}

# 2
GET /game/yolo80/player/1 HTTP/1.1
Host: tictactoe.haskell.lt:80
Accept: application/json+map

# 2nd player
telnet tictactoe.haskell.lt 80

# 1
GET /game/yolo80/player/2 HTTP/1.1
Host: tictactoe.haskell.lt:80
Accept: application/json+map

# 2
POST /game/yolo80/player/2 HTTP/1.1
Host: tictactoe.haskell.lt:80
Content-Type: application/json+map
Content-Length: 49

{"c": {"0": 1, "1": 1}, "v": "x", "id": "Ljuss2"}


# Example
> POST /setMap HTTP/1.1
> Host: www.example.com
> Content-Type: application/json; charset=utf-8
> Content-Length: 47
>
> {"mapName":"myMapName","mapURL":"http://tinypic.com/myimg"}

json be masyvų

# Initial HTTP testing in haskell
stack ghci
:l Client
makePostRequest
