# Running Ubuntu on Macbook Pro 2018

- Disabled boot security <https://support.apple.com/en-us/HT208198>
- Ubuntu 20.04 LTS booted
  - Keyboard and Touchpad didn't work.
  - WiFi was not working
  - External keyboard was not working in browser and terminal.
- Xubuntu 20.04
  - Keyboard and Touchpad didn't work.
  - WiFi was not working
  - External keyboard is functioning properly.
- Found the gist
    <https://gist.github.com/TRPB/437f663b545d23cc8a2073253c774be3>. This gives
    the steps for Arch Linux.
- Found <https://geeks-world.github.io/articles/472106/index.html>
- Working through <https://help.ubuntu.com/community/LiveCDCustomization> and
    <https://wiki.ubuntu.com/Kernel/BuildYourOwnKernel> to learn how to build
    ubuntu iso.
    - If you are using `apt-get source linux-image-$(uname -r)` to get the
        kernel source, user `apt-get source linux` instead since the other
        package is only a meta package.
    - Some more info about building Ubuntu kernel:
        <https://askubuntu.com/questions/1048332/recompile-linux-kernel-of-ubuntu-18-04-with-patch-for-intel-display-drivers>
    - The iso created by mkisofs has some problem with partition table. Picked
        up some commands from
        <https://help.ubuntu.com/community/InstallCDCustomization>

## TODO:
- Try https://stackoverflow.com/questions/49314556/how-to-build-my-own-custom-ubuntu-iso-with-docker
- https://help.ubuntu.com/community/LiveCDCustomization
