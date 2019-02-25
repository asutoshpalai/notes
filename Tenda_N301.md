# Tenda N301 / Router / Wireless N300 Easy Setup Router
Wifi Router: <https://www.tendacn.com/en/product/N301.html>


## Firmware

- Download page <https://www.tendacn.com/en/product/support/N301.html>
- version: V12.01.01.28
- Hashes:
  - MD5 (US_N301V2.0RTL_V12.01.01.28_multi_TDE01.bin) =
      ccb0bd9751070b71fd9f76420742ba54
  - MD5 (US_N301V2.0RTL_V12.01.01.28_multi_TDE01.zip) =
      5afed278d67a9b923111ed5038d9fe8c

### Updater analysis

File name: US_N301V2.0RTL_V12.01.01.28_multi_TDE01.bin

- Magic bytes: RTK0
- Binwalk extracted the firmware. Running `binwalk` on it revealed that the arch
    was **MIPS big endian**.
- String found at offset 0x1c: `cs6c`
  - Googling gave the header structure
      <https://github.com/cobyism/edimax-br-6528n/blob/7186a45c0383214ca6e02ece01f2c2cca63a1c8d/boot-source/bootcode_rtl8196c_98/boot/init/rtk.h#L53>
- Header structure:
    ```
    /* Firmware image header */
    struct _header_ {
      unsigned char signature[SIG_LEN];
      unsigned long startAddr;
      unsigned long burnAddr;
      unsigned long len;

    };

    ```

- Header details:
  - signature: cs6c
  - startAddr: 0x80500000
  - burnAddr: 0x8000
  - len: 0xd2802

- Loading the image as MIPS BigEndian binary from the file at 0x8050000 with
    file offset at 0x2c (0x1c + sizeof(_header_)) we can see that the strings in
    the binary are properly referenced!
