# ssd1331_demo_esp32

The build scripts for https://github.com/lexus2k/lcdgfx

# Introduction

This is a simple application with NuttX OS.

# Prerequisite

 - Hardware
  - Using ESP32-DevKitC-32 (ESP32-DevKitC-32D,ESP32-DevKitC-32E)
  - SSD1331 (96RGB x 64 Dot Matrix OLED)
 - Build environment
  - Linux Environment (WSL is fine as well)
  - Using Docker

# How to build

## step0

Clone this project.

```
$ git clone https://github.com/wurly200a/ssd1331_demo_esp32.git
$ cd ssd1331_demo_esp32
```

## step1

Build docker image as a builder.

```
$ build/01_build-builder.sh
```

## step2

Enter a builder.

```
$ build/02_enter-builder.sh
```

## step3

Build.

```
$ build/03_build.sh
```

# Execution Result

The artifacts will be located in the following locations.

 - ssd1331_demo_esp32\lcdgfx\bld\esp32\build\bootloader\bootloader.bin
 - ssd1331_demo_esp32\lcdgfx\bld\esp32\build\partitions_singleapp.bin
 - ssd1331_demo_esp32\lcdgfx\bld\esp32\build\ssd1331_demo.bin

