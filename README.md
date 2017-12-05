# notakto

# Work plan
1. Find partner.
1. Test telnet: is it single move passing or all moves? - ALL

Atom and haskell setup: https://github.com/simonmichael/haskell-atom-setup

Test solution: https://stackoverflow.com/a/43264723

# It does not
* detect, if same playerID makes two turns twice.

# HTTP
telnet tictactoe.haskell.lt 80

# 1
POST /game/yolo113/player/1 HTTP/1.1
Host: tictactoe.haskell.lt:80
Content-Type: application/json+map
Content-Length: 44

{"c": {"0": 1, "1": 1}, "v": "x", "id": "1"}


# 2
GET /game/yolo110/player/1 HTTP/1.1
Host: tictactoe.haskell.lt:80
Accept: application/json+map

#3
POST /game/yolo130/player/1 HTTP/1.1
Host: tictactoe.haskell.lt:80
Content-Type: application/json+map
Content-Length: 152

{"c": {"0": 1, "1": 2}, "v": "x", "id": "1", "prev": {"c": {"0": 0, "1": 0}, "v": "x", "id": "2", "prev": {"c": {"0": 1, "1": 1}, "v": "x", "id": "1"}}}


# 2nd player
telnet tictactoe.haskell.lt 80

# 1
GET /game/yolo119/player/2 HTTP/1.1
Host: tictactoe.haskell.lt:80
Accept: application/json+map


# 2
POST /game/yolo145/player/2 HTTP/1.1
Host: tictactoe.haskell.lt:80
Content-Type: application/json+map
Content-Length: 98

{"c": {"0": 2, "1": 2}, "v": "x", "id": "2", "prev": {"c": {"0": 1, "1": 1}, "v": "x", "id": "1"}}


POST /game/yolo146/player/2 HTTP/1.1
Host: tictactoe.haskell.lt:80
Content-Type: application/json+map
Content-Length: 98

{"c": {"0": 2, "1": 2}, "v": "x", "id": "2", "prev": {"c": {"0": 1, "1": 1}, "v": "x", "id": "1"}}

# Opponent DEFENCE
GET /game/yolo164/player/2 HTTP/1.1
Host: tictactoe.haskell.lt:80
Accept: application/json+map


POST /game/yolo164/player/2 HTTP/1.1
Host: tictactoe.haskell.lt:80
Content-Type: application/json+map
Content-Length: 98

{"c": {"0": 2, "1": 2}, "v": "x", "id": "2", "prev": {"c": {"0": 1, "1": 1}, "v": "x", "id": "1"}}


GET /game/yolo164/player/2 HTTP/1.1
Host: tictactoe.haskell.lt:80
Accept: application/json+map


POST /game/yolo164/player/2 HTTP/1.1
Host: tictactoe.haskell.lt:80
Content-Type: application/json+map
Content-Length: 206

{"c": {"0": 2, "1": 0}, "v": "x", "id": "1", "prev": {"c": {"0": 0, "1": 1}, "v": "x", "id": "1", "prev": {"c": {"0": 2, "1": 2}, "v": "x", "id": "2", "prev": {"c": {"0": 1, "1": 1}, "v": "x", "id": "1"}}}}


GET /game/yolo164/player/2 HTTP/1.1
Host: tictactoe.haskell.lt:80
Accept: application/json+map


POST /game/yolo164/player/2 HTTP/1.1
Host: tictactoe.haskell.lt:80
Content-Type: application/json+map
Content-Length: 314

{"c": {"0": 0, "1": 0}, "v": "x", "id": "1", "prev": {"c": {"0": 1, "1": 2}, "v": "x", "id": "1", "prev": {"c": {"0": 2, "1": 0}, "v": "x", "id": "1", "prev": {"c": {"0": 0, "1": 1}, "v": "x", "id": "1", "prev": {"c": {"0": 2, "1": 2}, "v": "x", "id": "2", "prev": {"c": {"0": 1, "1": 1}, "v": "x", "id": "1"}}}}}}

# Opponent ATTACK
POST /game/yolo164/player/1 HTTP/1.1
Host: tictactoe.haskell.lt:80
Content-Type: application/json+map
Content-Length: 44

{"c": {"0": 1, "1": 1}, "v": "x", "id": "1"}


GET /game/yolo164/player/1 HTTP/1.1
Host: tictactoe.haskell.lt:80
Accept: application/json+map


POST /game/yolo164/player/1 HTTP/1.1
Host: tictactoe.haskell.lt:80
Content-Type: application/json+map
Content-Length: 152

{"c": {"0": 2, "1": 1}, "v": "x", "id": "1", "prev": {"c": {"0": 0, "1": 0}, "v": "x", "id": "2", "prev": {"c": {"0": 1, "1": 1}, "v": "x", "id": "1"}}}


GET /game/yolo164/player/1 HTTP/1.1
Host: tictactoe.haskell.lt:80
Accept: application/json+map


POST /game/yolo164/player/1 HTTP/1.1
Host: tictactoe.haskell.lt:80
Content-Type: application/json+map
Content-Length: 260

{"c": {"0": 1, "1": 0}, "v": "x", "id": "1", "prev": {"c": {"0": 0, "1": 2}, "v": "x", "id": "2", "prev": {"c": {"0": 2, "1": 1}, "v": "x", "id": "1", "prev": {"c": {"0": 0, "1": 0}, "v": "x", "id": "2", "prev": {"c": {"0": 1, "1": 1}, "v": "x", "id": "1"}}}}}


# end
