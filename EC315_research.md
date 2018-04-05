- https://pastebin.com/NcGy8Fr7
- https://androidforums.com/threads/virgin-mobile-sprint-help-qualcomm-hs-usb-qdloader-9008.869613/

  ```
  dbl.mbn - Device Boot Loader
  osbl.mbn - OS Boot Loader
  partition.mbn - MBR sector
  ```

- For http://forum.gsmhosting.com/vbb/f804/huawei-modem-universal-flasher-1495518/index23.html#post9851968

  ```
  Rename extracted firmware parts as follows:
  01.bin -> partition.mbn;
  02.bin -> dbl.mbn;
  03.bin -> osbl.mbn;
  04.bin -> amss.mbn;
  05.bin -> dsp1.mbn;
  06.bin -> dsp2.mbn.
  ```

- [Reverse Engineering Android's Aboot](http://www.newandroidbook.com/Articles/aboot.html)

```
morpheus@Forge (~/S5/)% od -A d -t x4 aboot |head -5
                 Magic             Version             NULL            ImgBase
0000000          00000005          00000003          00000000          0f800000
                 ImgSize           CodeSize      ImgBase+CodeSize      SigSize
0000020          00107e24          000fed24          0f8fed24          00000100
         ImgBase+CodeSize+SigSize    Certs
0000040          0f8fee24          00009000          ea000006          ea005487
0000048          ea00548d          ea005493          ea005499          ea00549f
0000064          ea00549f          ea0054b6          ee110f10          e3c00a0b
```

- http://blog.azimuthsecurity.com/2013/05/exploiting-samsung-galaxy-s4-secure-boot.html
- http://blog.azimuthsecurity.com/2013/04/unlocking-motorola-bootloader.html
- https://askubuntu.com/questions/634180/minicom-status-stays-offline
- [Reverse engineering a Qualcomm baseband](https://events.ccc.de/congress/2011/Fahrplan/attachments/2022_11-ccc-qcombbdbg.pdf)

  Recomends to use `AT$QCDMG` to enable diag mode
- https://forum.xda-developers.com/showthread.php?t=2396752
- [QC BQS Firmware Analyzer - learnt about efs2 magic stings](http://forum.modopo.com/diskussionen-rund-ums-modding/t-19197-qc-bqs-firmware-analyzer/page44.html#post189000)

- [Res OS] (https://en.wikipedia.org/wiki/REX_OS)
- [osa  files from another device](http://www.pudn.com/Download/item/id/1019687.html)
- [osa homepage](http://wiki.pic24.ru/doku.php/en/osa/ref/introduction/intro#what_is_osa)
- [osa\_semaphore.h](https://github.com/bushuhui/pi-slic/blob/master/Thirdparty/PIL/src/base/osa/osa_semaphore.h)
- [wpscli source (probably leaked)](https://github.com/elenril/VMG1312-B/blob/master/bcmdrivers/broadcom/net/wl/impl10/wps/wpscli/linux/wpscli_wlan.c)
- [CBW and USBC explanantion](https://books.google.co.in/books?id=zSv3BwAAQBAJ&pg=PA357&lpg=PA357&dq=CBW+usbc&source=bl&ots=74N3yJ4wK8&sig=vrZE6pc0CYeD_l2cp1lMuYbIrlQ&hl=en&sa=X&ved=0ahUKEwi0mcT04v_VAhWKPY8KHXRUDn0Q6AEIOjAE#v=onepage&q=CBW%20usbc&f=false)
- [ Android/HTC/Vision/BootProcess – TJworld : Really detailed explanation of boot process](http://tjworld.net/wiki/Android/HTC/Vision/BootProcess)
- [Mobile Data modem user guide](https://electronix.ru/forum/index.php?act=Attach&type=post&id=102723)
- [](https://blogs.gnome.org/dcbw/2010/04/15/mobile-broadband-and-qualcomm-proprietary-protocols/)
- [rtf file with links to some usefull codes](https://saturn.ffzg.hr/rot13/index.cgi/asterisk_gsm.rtf?action=rtf_export;page_selected=asterisk_gsm)
- [some more qualcomm source
  codes](https://github.com/Bigcountry907/HTC_a13_vzw_Kernel/tree/master/vendor/qcom/proprietary)
  and [some more](https://v2.pikacode.com/jsr-d10/qcom_msm8626_adsp_proc/raw/ae282f66e175a6a585b5f9b9daade693b9f736ef/core/api/services/diagpkt.h)
- [DIAG protocol description](https://books.google.co.in/books?id=lky3BgAAQBAJ&pg=PA46&lpg=PA46&dq=qualcomm+diag+mode+dump+memory&source=bl&ots=LOj9plB5jZ&sig=rkEUC-gY782oHae8g6_3DFM3kNI&hl=en&sa=X&ved=0ahUKEwjgj7CzpoLWAhVJvI8KHSyeDGwQ6AEIMzAB#v=onepage&q=qualcomm%20diag%20mode%20dump%20memory&f=false)
