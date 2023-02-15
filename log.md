### Random
- proxychains is simply great!
- You can mess with decodeURIComponent with unicode character sequences like
    "%0A" and "%3D%93".
- Attaching VS to a process on startup: Gflags with debugger as
  c:\windows\system32\VSJitDebugger.exe
- Messing around MacOS pkg files <https://stackoverflow.com/a/11299907>
- RAM Disk on MacOS
    https://web.archive.org/web/20160419023835/http://www.frederico-araujo.com/2008/12/18/blazing-fast-firefox-using-osx-ramdisk/
- align multiple image based on common parts:
    <https://photo.stackexchange.com/a/49597>

- MacOS run a script as an App, use Automator -> Create Application -> Run a
    script -> Input as arguements -> path to the scirpt/directly input the
    script
- Fixing Scaleway Ubuntu Kernel
<https://blog.simos.info/how-to-run-the-stock-ubuntu-linux-kernel-on-scaleway-using-kexec-and-server-tags/>

- "HowTo: Use Tor for all network traffic by default on Mac OS X"
<https://maymay.net/blog/2013/02/20/howto-use-tor-for-all-network-traffic-by-default-on-mac-os-x/>
- Poor man's SSH VPN <https://github.com/sshuttle/sshuttle>
- CA cert signing fails to copy extensions:
    <https://security.stackexchange.com/questions/150078/missing-x509-extensions-with-an-openssl-generated-certificate>
- CA signing with random date: <https://github.com/wolfcw/libfaketime>. Doesn't
    work on MacOS, can use Docker to get around.

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

# dotNet executables
  - Nice decompilation with JetBrains dotPeek
  - Obfuscation trick: Use unicode names that looks like operators or spaces.

# Debugging dlls with a debugger:

- use rundll32.exe as the application, the dll file as input file, the dll file
    name as the parameter (and if any specific exported function is to be
    called, the same too).
- 64-bit version of `rundll32.exe`: `%WinDir%\System32\rundll32.exe`
- 32-bit version of `rundll32.exe`: `%WinDir%\SysWOW64\rundll32.exe`

# Vim Tricks
- Fixed text width writing with vim <http://blog.ezyang.com/2010/03/vim-textwidth/>
- For C++ files and LSP using clangd, you can find the compile flags in the logs
    of CMake.

# Debugging PIE with Radare2
- Reload with `ood`. 
- Do a binary kinda search with something link `ood; dso 10`, `ood; dso 20` to
    find the value of argument to `dso` for which the program starts executing.
- Then do 2 `ds` and repeat the above steps to find the correct number of second
    `dso` like `ood;dso 40; ds 2; dso 60; ds`.
- Keep doing this till you find the main.
- Then follow the same for breakpoints in different functions
- Tricks like `dcu $$+20` can be used to pass over loops. E.g. `ood;dso 40;ds 2;
    dso 60;ds; dcu $$+146`. This can be used to directly jump to/set bp at
    functions after reaching `main` (using relative address).
- Another trick is, when r2 id started with a debugging session (`-d` option)
    along with the analyse option (`-AA`), it recognises the functions
    correctly. This can be helpful along with executing command option (`-c`)
    like:

    $ r2 -d -AA ./binary -r target.rr2 -c 'dcu sym.func1+121; pxr 20 @
    esp+184; dso; pxr 20 @ esp+184'

# x64 ROP gadgets
- It generally difficult to find the gadgets to manipulate all the argument
    registers (`rdi`, `rsi`, `rdx`) in small binaries. But there is a great gadget in
    the `__libc_csu_init` section. This gadget can be used to call functions
    with proper arguments.

    ```asm
		00000000004005f0 <__libc_csu_init>:
			4005f0:       41 57                   push   r15
			4005f2:       41 56                   push   r14
			4005f4:       49 89 d7                mov    r15,rdx
			4005f7:       41 55                   push   r13
			4005f9:       41 54                   push   r12
			4005fb:       4c 8d 25 be 07 20 00    lea    r12,[rip+0x2007be]        # 600dc0 <__frame_dummy_init_array_entry>
			400602:       55                      push   rbp
			400603:       48 8d 2d be 07 20 00    lea    rbp,[rip+0x2007be]        # 600dc8 <__init_array_end>
			40060a:       53                      push   rbx
			40060b:       41 89 fd                mov    r13d,edi
			40060e:       49 89 f6                mov    r14,rsi
			400611:       4c 29 e5                sub    rbp,r12
			400614:       48 83 ec 08             sub    rsp,0x8
			400618:       48 c1 fd 03             sar    rbp,0x3
			40061c:       e8 17 fe ff ff          call   400438 <_init>
			400621:       48 85 ed                test   rbp,rbp
			400624:       74 20                   je     400646 <__libc_csu_init+0x56>
			400626:       31 db                   xor    ebx,ebx
			400628:       0f 1f 84 00 00 00 00    nop    DWORD PTR [rax+rax*1+0x0]
			40062f:       00 
			400630:       4c 89 fa                mov    rdx,r15
			400633:       4c 89 f6                mov    rsi,r14
			400636:       44 89 ef                mov    edi,r13d
			400639:       41 ff 14 dc             call   QWORD PTR [r12+rbx*8]
			40063d:       48 83 c3 01             add    rbx,0x1
			400641:       48 39 dd                cmp    rbp,rbx
			400644:       75 ea                   jne    400630 <__libc_csu_init+0x40>
			400646:       48 83 c4 08             add    rsp,0x8
			40064a:       5b                      pop    rbx
			40064b:       5d                      pop    rbp
			40064c:       41 5c                   pop    r12
			40064e:       41 5d                   pop    r13
			400650:       41 5e                   pop    r14
			400652:       41 5f                   pop    r15
			400654:       c3                      ret    
			400655:       90                      nop
			400656:       66 2e 0f 1f 84 00 00    nop    WORD PTR cs:[rax+rax*1+0x0]
			40065d:       00 00 00 

    ```
- Check the portion near `0x400630` till `0x400639` which forms the calling
   gadget and the portion near `0x40064a` till `0x400654` which helps in loading
   the required registers.

- To pass the jump statement in `0x400644`, set `rbp` to `rbx + 1` so that after
    increment both are equal.

- The above trick can be packaged into a function:
    ```python
		def call_csu_rop(target_func, edi, rsi, rdx):
						return [
										0x40064a, # pop rbx; pop rbp; pop r12; pop r13; pop r14; pop r15; ret
										0x00, # rbx
										0x01, # rbp, 
										target_func, # r12 = targe
										edi, # r13 = edi
										rsi, # r14 = rsi 
										rdx, # r15 = rdx = got.memset
										0x400630, #mov    rdx,r15; mov    rsi,r14; mov    edi,r13d; call   QWORD PTR [r12+rbx*8]; add    rbx,0x1;  cmp    rbp,rbx; jne    400630; add    rsp,0x8; pop rbx; pop rbp; pop r12; pop r13; pop r14; pop r15; ret
										0xdeadbeef,
										0xdeadbeef,
										0xdeadbeef,
										0xdeadbeef,
										0xdeadbeef,
										0xdeadbeef,
										0xdeadbeef,
						]
    ```

# Ethereum

- [Go Etherium](https://geth.ethereum.org/) can be used to set up a node
- web3 clients can be used to communicate with the node through RPC
- Contracts are programs whose functions can be called and they can have states
    which can also change. I believe that for calling the functions that change
    the states, you need to create a transaction.

# PHP Sessions
- Using `redis` store for session storage:
    <https://www.digitalocean.com/community/tutorials/how-to-set-up-a-redis-server-as-a-session-handler-for-php-on-ubuntu-14-04>
- Using Memcached <http://php.net/manual/en/memcached.sessions.php>
- Sticky sessions at load balance, the load balancer forwards request to same
    server depending upon the session.

# Debugging binaries with differnt archs:
- start the binary under QEMU like `qemu-arm -g 1735 -R 20M -L /usr/arm-linux-gnueabi/
    ./binary`
- This makes QEMU to pause till a gdb get attached to the port 1735
- attach `gdb-multiarch` like `gdb-multiarch -q -x ~/.gdbinit-pwndbg ./target -ex
    'target remote 127.0.0.1:1735' -ex 'b main' -ex 'c'`
- Add the shared library paths to gdb using `sysroot`.

# Running ARM ELF on a different architecture

- To compile, first install `gcc-arm-linux-gnueabi`.
- To run, install `qemu` and while running using `qemu-arm` provide the path to
  libs like `qemu-arm -L /usr/arm-linux-gnueabi/ binary`

# Debian/Ubuntu equivalanet of ABS (how debian pacakges are built)

- There is a plugin for `bzr` which can be installed from apt which is used to
  manage the packge building process and uploading it to launchpad. I am
  guessing a software by name of `dh-build` helps in that. Details:
  <http://packaging.ubuntu.com/html/packaging-new-software.html>
- Things concering the building is a `debian` folder inside the source directory
  which, more importantly the `control` and `rules` files, that describes the
  building. More info at <https://askubuntu.com/a/17519> and
  <https://stackoverflow.com/a/13517588>
- Best thing of all, you can directly use apt-get to build from source! Damn,
  imagine! 

    $ apt-get -b source libc6

- To add/change the compilation flags: <https://stackoverflow.com/a/11115046>

# Debugging libc/ld (or any shared libaray) with source

- <https://stackoverflow.com/a/29956038>
- If the symbols are not getting loaded from `/usr/lib/dbg`, create a `.debug`
    folder in the same dir from which the library is being loaded and place the
    debug symbols file in it. E.g., for `/lib64/ld-linux-x86-64.so.2`, symlink
    `/usr/lib/debug/lib/x86_64-linux-gnu/ld-2.27.so` to
    `/lib64/.debug/ld-2.27.so`.

# WiFi monitor mode on macOC

- You need to dissociate from any AP before initiating the scanning:
```
sudo /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -z
```

- Open Wireshark, while selecting interface check the monitor mode checkbox and
    start capturing.
- The above command can also be used to switch channel with `-c` option, e.g.
    `-c5`

# OpenSSL on macOS

```
export LDFLAGS=-L/usr/local/opt/openssl/lib
export CPPFLAGS=-I/usr/local/opt/openssl/include
export PKG_CONFIG_PATH="/usr/local/opt/openssl/lib/pkgconfig"
```

# Patching android executables

- Copy the appropriate directory from <https://github.com/DexPatcher/dexpatcher-gradle-samples>
- If you see invalid character in resources error:
<https://github.com/DexPatcher/dexpatcher-gradle/issues/24>
- If starting in debug mode fails with error "Session 'app': Error Launching
    activity"
  - Start in debug mode and let it fail
  - Goto "attach debugger to Android process" and select the application
- If you see that certain classes already exits, have the name of the `package`
  `AndroidManifest.xml` in `app/src/main/` different from what you have for
  original `AndroidManifest.xml`
- If the build fails due to 'aar' errors (can't reproduce the error messages
    now), run one of the dexpatcher gradle tasks like `decodeApk`


# Windows RE

- Inno Setup extractor [InnoExtract](https://github.com/dscharrer/InnoExtract)

# Firmware chrooting

- Ref: <https://unix.stackexchange.com/a/222981>
  
  $ cp $(which qemu-arm-static) /mnt/usr/bin

  $ chroot /mnt qemu-arm-static /bin/bash

- You can activate the gdb server shim in Qemu using `QEMU_GBD=<port>` env var before
  running any program. Ref: <https://unix.stackexchange.com/q/129366>

# Setting up Windows VM for gaming

## GPU passthrough with single GPU
- Make host kernel not use the GPU:
  `GRUB_CMDLINE_LINUX_DEFAULT="quiet iommu=pt amd_iommu=on video=efifb:off""`
      in  `/etc/default/grub`
- Blacklist kernel drivers. It is necessary, otherwise AMD driver causes kernel
    panics on host.
- Added vendor IDs for `vfio-pci`.
- Ref:
    <https://blog.quindorian.org/2018/03/building-a-2u-amd-ryzen-server-proxmox-gpu-passthrough.html/>
    and <https://pve.proxmox.com/wiki/Pci_passthrough>
- To read: <https://github.com/joeknock90/Single-GPU-Passthrough>
- Other helpful tools:
  - <https://github.com/ystarnaud/amdmeminfo>
  - <https://github.com/awilliam/rom-parser>

## Making Xbox One S controller to work with wired connection
- Blacklist the `xpad` driver, `modprobe -r` should work too.

# Compiling nfs-ganesha (v3.0.3) on Ubuntu 18.04

I needed this to support NFS for GlusterFS on Odroid HC2.

- Install dependencies

    $ apt install git cmake pkg-config libcap-dev libnfsidmap-dev dbus libacl1-dev ncurses-dev libkrb5-dev uuid-dev liburcu-dev bison flex

- On Odroid I had to remove the FindPkg CMake library that was bundled for
    `pkg-config` to function properly.

    $ rm ./src/cmake/modules/FindPkgConfig.cmake

- Create a build directory and run cmake

    $ cmake -DUSE_FSAL_GLUSTER=ON -DCURSES_LIBRARY=/usr/lib64 -DCURSES_INCLUDE_PATH=/usr/include/ncurses -DCMAKE_BUILD_TYPE=Maintainer /root/nfs-ganesha/src/

# Xpra

I am trying to run Ubuntu 20.04 in a LXC container and access GUI apps remotely
via xpra.

- Works out of box (using the CLI) but has lower DPI.
- Ref: <https://xpra.org/trac/wiki/DPI>, need to load Xdummy and FakeXinerama.
- Adding FakeXinerama was easy.
- Added the conf for Xdummy to `/etc/xpra/xpra.conf`, ref:
    <https://xpra.org/trac/wiki/Xdummy>. X fails to start now.

# OpenWRT on KVM (Proxmox)

- Followed <https://www.jwtechtips.top/how-to-install-openwrt-in-proxmox/> to
    install OpenWRT.
  - Before I started the VM for the first time, I expanded the disk. This will
      auto expand the overlay disk. 
- After boot, edited `/etc/config/networks` to change `eth0` to `wan` & `dhcp`.
- Edited `/etc/config/firewall` to allow ssh on wan.
- Install `kmod-iwlwifi` and download `iwlwifi-cc-46` ucode to `/lib/firmware`
to make the Intel AX200 WiFi card working (used snapshot version of  OpenWRT
for have 5.2+ kernel).
- Setup routed AP <https://openwrt.org/docs/guide-user/network/wifi/routedap>
  - Install `hostapd`.
  - In the line `config wifi-device 'wlan0'`, use the name of the actual
  interface.
- Install `luci-ssl` for web interface.
- Followed <https://openwrt.org/docs/guide-user/services/tor/client> to set up
tor. Connection rerouting was working, DNS failed.

# Setting up Wifi Access Point that tunnels to another system

The aim was to setup 2 devies which are connected by Wireguard (Tailgate). One
of them will be a portable wifi hotspot which will tunnel all its traffic to
the other device.

- Bought 2 Odroid C4 devices and Odroid wifi doungles.
- Setting up both the wifi doungles on the same system doesn't work because same
    Realtek driver (which for Odroid doungles 8821cu) can't handle two differnt
    devices. Ref: <https://github.com/morrownr/88x2bu/issues/73>
- So, I bought another Wifi doungle labled AC650. After receiving it, I realized
    that it also uses the same driver, 8821cu.

    But one of the [comments](https://github.com/morrownr/88x2bu/issues/73#issuecomment-869078979)
    mentioned in the above linked issue is to compile the
    driver with differnt names so that kernel loads two different instances of
    the same driver. That didn't work earlier as both the doungles had the same
    device ID. But in this case, they had different device IDs.

    So, I compiled 2 versions of the driver, by commenting out the different
    device IDs in each for each doungles. That actually worked and I was able to
    use both the doungles.
- I setup one of the Odroid C4 as Tailscale [exit
    node](https://tailscale.com/kb/1103/exit-nodes/).
- On the other Odroid, I setup [comitup](http://davesteele.github.io/comitup/)
    to help setup wifi connections in a new place without using any screen or
    keyboard. With 2 wifi doungles on the same device, is setups an AP on one
    and it automatically uses the other wifi doungle to connect to the WiFi
    network. It forwards the traffic from the AP to the WiFi network
    automatically.
- Then I setup Tailscale on it and configured it to use the exit node to route
    all the traffic. It worked well for connections originating from the Odroid
    device but it didn't work for the AP traffic. The following iptables rule
    fixed it. Then installed `iptables-persistent` to save it across reboot.
    ```
        $ iptables -t nat -A POSTROUTING -o tailscale0 -j MASQUERADE
    ```
