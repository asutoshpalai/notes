# 125KHz RFID/ID EM USB IC Card Reader Writer Copier Duplicator

Analysis of a cheap RFID reader I got from Ebay.

## Initial analysis
- `lsusb` identifies it as `1a86:dd01 QinHeng Electronics`.
- Searched online for cheap RFID readers, found:
<https://gist.github.com/pgaultier/b870578515a18becc39ce4501a751574>
  - The gist said that the reader had a "CH341 USB / Serial Chip". I don't
  know what that is, have very less experience in hardware stuff.
  - The gist also had some messages for hello, read and write.
  - Didn't try the driver mentioned in the gist though.
  - I also found
      https://github.com/adrianmihalko/ch340g-ch34g-ch34x-mac-os-x-driver which
      said that for newer Mac OS you don't need the OEM drivers.
- Opened the cover and found that the one I had with me had "CH552T" chip.
- Searching for the chip, I found
<https://github.com/MarsTechHAN/ch552tool/blob/master/ch55xtool.py>, to flash
firmware on it. I used to code for references.
  - Tried the device identification code. It didn't provide the required
  response. Maybe the device is in some other mode.
  - Note: I ran pyusb on Linux VMware with USB forwarded because Mac OS didn't
  allow easy access to the HID interface. Maybe when the protocol is figured
  out, I can try hidapi (it has python bidnings) to try and connect from MacOS.

- Found "USB Serial for Android" app. It had a connection profile for ch340, which
was able to establish connection but erred out on some handshake profile.
  - Downloaded <https://github.com/mik3y/usb-serial-for-android> and looked at
  the code in `Ch34xSerialDriver` class. It has some control in, control out for
  init. When I reproduced the first one, it didn't work as expected.
- Used chrome translate to reach <http://www.wch.cn/downloads/CH552EVT_ZIP.html>
which lists some header files. The description also said about `CH554EVT.ZIP`
which contains examples.
  - CH554EVT.ZIP had many C code, but a lot of them had comments in Chinese
  language. Used Google translate to read them.

- Imaged the disk provided on another laptop and transferred the file here. Found
the DLL file with protocol.
  - Tried to imitate the protocol with pyusb, didn't work.
  - Ran it with Wireshark USB capture to iron out the details that I counldn't
  infer from the DLL, like all packets start with 0x01, and are 64 byte sized.
  The unused data is filled with 0xCC.
  - running in Windows VM, I couldn't get any HID Prox cards to read, so couldn't
  test the read/write opcodes.
  - Was able to write to one of the cards provided with the reader and then read
  back using pysub or hidapi to connect to the device.

## Protocol
- All packets are 64 byte sized, input & output. Maybe larger data will require
more packets, will cross the bridge when we need that.
- the payload are structured like:
```
   0xAA 0x55 0xWW 0xWW 0xOP 0xOP 0xPL 0xPL [payload in hex] 0xCX
```
where:
  - `0xAA 0x55` is the header.
  - `0xWW 0xWW` represents some data that I always have found to be 0 in request
  and 0x1112 in response.
  - `0xOP 0xOP` represents the opcode in big endian.
  - `0xPL 0xPL` represents the payload length in big endian.
  - `[payload]` represents the payload.
  - `0xCX` represents the XOR of all the bytes excluding the header bytes.
  - Any occurrence of by `0xAA` except in header is escaped as `0xAA 0x00`.

- Each packet is 64 bytes and starts with `0x01` followed by 63 bytes of payload
data. Any unused bytes in the packet is filled with 0xCC.
- The opcodes are as follows:
```
OPCODE_SET_AUTOREAD = 0x801 # one byte payload, always found to be 0
OPCODE_SET_LED = 0x802 # one byte payload, 2 = green, anything else is red
OPCODE_GET_FREQUENCY = 0x805 # no payload
OPCODE_GET_MODEL = 0x806 # no payload
OPCODE_GET_NUMBER = 0x808 # no payload
OPCODE_READ_ID_CARD = 0x809 # no payload
OPCODE_WRITE_EL4100 = 0x810 # 5 byte payload, data to be written
OPCODE_WRITE_T4100 = 0x811 # 6 byte payload, first is 0 or 1, rest is data to be
written. Maybe the first byte is to lock the card or not
OPCODE_WRITE_E4100 = 0x812 # 6 byte payload, first is 0 or 1, rest is data to be written
```

## Working with cards:
- The device I had was not able to read HID cards.
- The cards that came with the device were able to be written using
`OPCODE_WRITE_T4100`.
