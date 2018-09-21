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

# To open a socks proxy on local with proxy chaining

- Setup your proxychains config and run
    [`srealy`](https://socks-relay.sourceforge.io/) under `proxychains` like

      $ proxychains4 -f proxychains.conf srelay -f

# SMT solvers

- online solver: <https://rise4fun.com/z3>
- Nice intro: <https://yurichev.com/writings/SAT_SMT_by_example.pdf>

# GUI from docker (on Mac)

- Worked for me
<https://fredrikaverpil.github.io/2016/07/31/docker-for-mac-and-gui-applications/>
- From r2's cutter project I learned
    <https://stackoverflow.com/questions/16296753/can-you-run-gui-apps-in-a-docker-container/25280523#25280523>.
    Although I didn't test it.

# Alpha numeric shellcode
- <http://phrack.org/issues/57/15.html#article>
- <http://julianor.tripod.com/bc/bypass-msb.txt>

# Installing Red Hat Virtualization Manage Python SDK
- The guide requires you to have a RHEL, closest you can get is spawn a CentOS
    docker container
- Apparently installing pip for CentOS is not that straight forward
    <https://www.liquidweb.com/kb/how-to-install-pip-on-centos-7/>
- Follow stuff from
    <https://www.linuxtechi.com/install-configure-ovirt-4-0-on-centos7-rhel7/>
    and
    <https://www.ovirt.org/documentation/install-guide/chap-Installing_oVirt/>

    - Basically instead of `subscription-manager repos
        --enable=rhel-7-server-rhv-4.1-rpms` as per the SDK guide, you can do
        `yum install
        http://resources.ovirt.org/pub/yum-repo/ovirt-release41.rpm`
- From <https://pypi.org/project/ovirt-engine-sdk-python/4.1.0/>, pip
    install also works.
