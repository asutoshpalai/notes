### Random
- proxychains is simply great!
- You can mess with decodeURIComponent with unicode character sequences like
    "%0A" and "%3D%93".
- Attaching VS to a process on startup: Gflags with debugger as
  c:\windows\system32\VSJitDebugger.exe
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

# Fixed text width writing with vim

- <http://blog.ezyang.com/2010/03/vim-textwidth/>

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
