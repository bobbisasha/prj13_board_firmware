# 🦇 BLE Ultrasonic Sensor (TI CC26xx & Sensor Controller)

Ultra-low-power firmware for reading an ultrasonic distance sensor (A02YYUW or UART-compatible equivalent) and streaming distance telemetry over BLE.

The firmware splits work across the CC26xx's dual-core architecture to maximize battery life:

- **Sensor Controller** (low-power coprocessor): powers the sensor, emulates UART, and fills a FIFO buffer in shared AUX RAM.
- **Main ARM Processor**: stays in Deep Sleep, waking only to read the FIFO, compute distance, update the BLE GATT profile, and sleep again.

---

## 🔌 Hardware & Pinout

| Function | CC26xx Pin | Sensor Pin | Notes |
|---|---|---|---|
| UART RX | `DIO2` | Sensor TX | 9600 baud |
| UART TX | `DIO1` | Sensor RX | Optional / unused |
| Power (VCC) | `DIO5` | VCC / MOSFET | Sensor Controller powers the sensor only during active readings |
| GND | `GND` | GND | Common reference |

---

## ⏱️ Polling & Power Management

- **Interval:** sensor is polled every **10 s**.
- **Flow:** on each timer tick, the ARM core wakes the Sensor Controller, which starts listening at 9600 baud.
- **Smart sleep:** the sensor needs ~100–150 ms to boot after power-up on `DIO5`. Rather than busy-wait, the ARM core sleeps 200 ms, then wakes to read a fully populated FIFO.
- **BLE standby:** if the BLE connection drops (`GAPROLE_WAITING`), the polling timer stops and the sensor is powered off entirely.

---

## 📏 UART Frame & Distance Calculation

Each reading is a 4-byte frame:

| Byte | Meaning |
|---|---|
| 0 | Header (`0xFF`) |
| 1 | Distance MSB |
| 2 | Distance LSB |
| 3 | Checksum (sum of bytes 0–2) |

The firmware validates the checksum, merges the MSB/LSB into a distance value, and updates the BLE characteristic if the reading is within range (≤ 4.5 m):

```c
if (scifUartGetRxFifoCount() >= 4) {
    uint8_t d0 = (uint8_t)scifUartRxGetChar();

    if (d0 == 0xFF) {
        uint8_t d1 = (uint8_t)scifUartRxGetChar(); // MSB
        uint8_t d2 = (uint8_t)scifUartRxGetChar(); // LSB
        uint8_t d3 = (uint8_t)scifUartRxGetChar(); // Checksum

        if (((d0 + d1 + d2) & 0xFF) == d3) {
            uint16_t distance_mm = (d1 << 8) | d2;

            if (distance_mm <= 4500) {
                SimpleProfile_SetParameter(SIMPLEPROFILE_CHAR1, sizeof(uint16_t), &distance_mm);
            }
        }
    } else {
        while (scifUartGetRxFifoCount() > 0) scifUartRxGetChar(); // out of sync, flush
    }
} else {
    while (scifUartGetRxFifoCount() > 0) scifUartRxGetChar(); // incomplete frame, flush
}

scifUartStopEmulator(); // power down sensor + controller
```

---

*Project 13 Board Firmware*
