# Motorized Chain Roller With WiFi

## Survey

- Two chips
    - Nation N32G030
        - Other markings: C8L7, NAB24001

    - WBR3
        - Only 6 pins are connected. Makes me think that it's only for WiFi
            connections with the other chips as the main chip. 
- P3 looks like debug pin out.
    - Let's call the square one T1. With that convention, we have T1 to T4.

## N32G030

- Data Sheet: https://www.nationstech.com/uploads/packs/1662538843129211.pdf
- C8L7 tell us that it's a flash of 64KB and 8KB SRAM
- ARM Cortex-M0 @48MHz
- GPIO 40
- Page 28 has data sheet.
- Using multimeter, 
    - T1 traces to pin 24, VDD
    - T2 traces to pin 34, PA13
    - T3 traces to pin 37, PA14
    - T4 traces to pin 23, VSS

### Connection OpenOCD to it

Googling above pin config points to the fact that it's a SWD interface. Since I
had a esp32 board, I am using that as a replacement for ST-Link USB.

- Flashed https://github.com/bkuschak/cmsis_dap_tcp_esp32 onto the ESP32.
- https://github.com/xbenkozx/RAZ-RE/blob/main/Firmware/readme.md has info on
    similar device.
- Copied the target file from OpenOCD from the above repo too.
- Ran the following to get the image dump.
```
openocd --search tcl \
    -f tcl/interface/cmsis-dap-tcp.cfg \
    -f tcl/target/n32g0x.cfg \
    -c "init; reset halt; dump_image firmware.bin 0x08000000 0x10000; shutdown"
```
-
