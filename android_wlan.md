# Context
- Checking out the wlan firmware of my device Moto G5 Plus (potter)

# Research
- Found the vendor firmwares files at
  [https://github.com/boulzordev/android_vendor_motorola_potter](https://github.com/boulzordev/android_vendor_motorola_potter)
- Found the wlan firmware at path
  [`proprietary/etc/firmware/wlan/prima`](https://github.com/boulzordev/android_vendor_motorola_potter/tree/lineage-15.1-64/proprietary/etc/firmware/wlan/prima)
- Searching for "android wlabn firmware load address" I found a issue for
  ["wlan-prima (wireless module) and
  wcnss-service"](https://github.com/postmarketOS/pmbootstrap/issues/373).
  Prima-wlan, match match!
  ```
  This is how it works:

  The wlan-prima kernel module is loaded
  wlan-prima tries to load the firmware (multiple files) (will be solved in issue #147)
  wcnss-service initializes the wireless interface
  ```
- Had the link for [wlan-prima source code](https://github.com/t2m-foxfone/android_platform_vendor_qcom-opensource_wlan_prima), but I also found it ini
[andoid kernel
tree](https://android.googlesource.com/kernel/msm/+/android-msm-mako-3.4-jb-mr1/drivers/staging/prima/). I used the former source. I also found similar code base for [android 8.1](://android.googlesource.com/kernel/msm/+/android-8.1.0_r0.9/drivers/staging/qcacld-2.0/), but it was a very different versoin and prelim search didn't reveal where the nv file was being loaded.
- Searching for "wlan_prima firmware load address", I found error messages
  "wcn36xx smd:riva@6:wcnss:wifi: loading
  /system/vendor/firmware/wlan/prima/WCNSS_qcom_wlan_nv.bin failed with
  error -13" and "wlan: [1006:F :VOS] vos_open: Failed to initialize the NV 
  module". The later was intresting because I saw VOS logging in the source
  code.
- Searching for the string landed me at vos_open in `CORE/VOSS/src/vos_api.c`.
- I called `vos_nv_open` in `vos_nvitem.c`.
- It loads `WLAN_NV_FILE` which points to our firmware file.
- It checks for magic number at 3rd and 4th byte `CAFEBABE` which is present in
  the firmware files.
- The first and second bytes are called "mask", didn't find any use of that in
  the code.
- The qcom nv files are arranged in form of streams.
