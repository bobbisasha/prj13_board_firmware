\# 🦇 BLE Ultrasonic Sensor (TI CC26xx \& Sensor Controller)



\## 📖 Project Overview

This project implements an ultra-low-power firmware for reading an ultrasonic distance sensor (e.g., model A02YYUW or compatible with UART output) and transmitting the telemetry data via Bluetooth Low Energy (BLE). 



The system leverages the dual-core architecture of Texas Instruments microcontrollers (such as the CC2640R2 or CC2642R1) to maximize battery life:

1\. The \*\*Sensor Controller\*\* (an ultra-low-power coprocessor) handles the physical power-up of the sensor, emulates a UART interface, and fills a FIFO buffer in the shared memory (AUX RAM).

2\. The \*\*Main ARM Processor\*\* remains in Deep Sleep most of the time. It wakes up only to fetch data from the FIFO, calculate the distance, update the Bluetooth GATT profile, and immediately go back to sleep.



\---



\## 🔌 Hardware Details \& Pinout

The wiring between the LaunchPad (or custom board) and the ultrasonic sensor is mapped as follows:



| Function | CC26xx Pin | Sensor Connection | Notes |

| :--- | :--- | :--- | :--- |

| \*\*UART RX\*\* | `DIO 2` | Sensor TX | Reads incoming serial data at 9600 baud. |

| \*\*UART TX\*\* | `DIO 1` | Sensor RX | \*(Optional/Unused)\*. |

| \*\*Power (VCC)\*\*| `DIO 5` | VCC / MOSFET | Managed by the Sensor Controller to power the sensor ONLY during active readings. |

| \*\*GND\*\* | `GND` | GND | Common ground reference. |



\---



\## ⏱️ Polling Interval \& Power Management

Sensor reading occurs periodically and is managed by the TI-RTOS system clock.



\* \*\*Polling Interval:\*\* The sensor is polled every \*\*10 seconds\*\* (`10000 ms`).

\* \*\*Execution Flow:\*\* When the periodic timer triggers, the ARM processor wakes up the Sensor Controller and instructs it to start listening at `9600 baud`.

\* \*\*Smart Sleep:\*\* The ultrasonic sensor requires roughly 100-150 ms to boot up and stabilize after receiving power via `DIO5`. To save energy, the ARM processor executes a `Task\_sleep` for \*\*200 ms\*\*, putting itself back into standby. It wakes up just in time to read the fully populated FIFO buffer.

\* \*\*BLE Standby:\*\* To prevent unnecessary battery drain, if the Bluetooth connection drops or is actively disconnected (`GAPROLE\_WAITING` state), the periodic timer is stopped and the sensor is powered off entirely.



\---



\## 📏 Distance Calculation \& UART Parsing

The sensor cyclically sends a 4-byte data frame structured as follows:

1\. `Byte 0`: Fixed Header (`0xFF`)

2\. `Byte 1`: Distance Data (MSB - High Byte)

3\. `Byte 2`: Distance Data (LSB - Low Byte)

4\. `Byte 3`: Checksum (Sum of the first three bytes)



The firmware validates the packet integrity using the Checksum and calculates the final distance by merging the High and Low bytes using a bitwise shift. 



Here is the core logic used in the main application task:



```c

// Check if at least 4 bytes (one full frame) are available in the FIFO

if (scifUartGetRxFifoCount() >= 4) {

&#x20;   uint8\_t d0 = (uint8\_t)scifUartRxGetChar();

&#x20;   

&#x20;   // Verify the Header

&#x20;   if (d0 == 0xFF) { 

&#x20;       uint8\_t d1 = (uint8\_t)scifUartRxGetChar(); // MSB

&#x20;       uint8\_t d2 = (uint8\_t)scifUartRxGetChar(); // LSB

&#x20;       uint8\_t d3 = (uint8\_t)scifUartRxGetChar(); // Checksum



&#x20;       // Verify data integrity (8-bit Checksum)

&#x20;       if (((d0 + d1 + d2) \& 0xFF) == d3) { 

&#x20;           

&#x20;           // Merge bytes to calculate the distance in millimeters

&#x20;           uint16\_t distance\_mm = (d1 << 8) | d2;

&#x20;           

&#x20;           // Filter out-of-bounds readings and update BLE Characteristic (Max 4.5 meters)

&#x20;           if (distance\_mm <= 4500) {

&#x20;               SimpleProfile\_SetParameter(SIMPLEPROFILE\_CHAR1, sizeof(uint16\_t), \&distance\_mm);

&#x20;           }

&#x20;       }

&#x20;   } else {

&#x20;       // Out of sync: flush the FIFO

&#x20;       while(scifUartGetRxFifoCount() > 0) scifUartRxGetChar();

&#x20;   }

} else {

&#x20;   // Incomplete data: flush the FIFO

&#x20;   while(scifUartGetRxFifoCount() > 0) scifUartRxGetChar();

}



// Safely turn off the Sensor Controller and remove power from the sensor

scifUartStopEmulator();"# Project 13 Board Firmware"

