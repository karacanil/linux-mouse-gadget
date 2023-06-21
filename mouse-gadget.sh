#!/bin/bash

# This script will setup a simple HID mouse/touch gadget via ConfigFS.
# In order to use it, you must have kernel >= 3.19 and configfs enabled

USB_HID_PATH="/sys/kernel/config/usb_gadget/example_gadget"
ID_VENDOR="0x0eef"
ID_PRODUCT="0x0001"
BCD_DEVICE="0x0100"
BCD_USB="0x0100"
MANUFACTURER="Example Manufacturer"
PRODUCT="Example Product"
MAX_POWER=100
CONFIGURATION="Configuration 1"
PROTOCOL=2
SUBCLASS=1
REPORT_LENGTH=4
UDC=fe200000.usb #Address of the USB interface goes here (ls /sys/class(udc)

modprobe libcomposite

mkdir -p $USB_HID_PATH
echo $ID_VENDOR > $USB_HID_PATH/idVendor
echo $ID_PRODUCT > $USB_HID_PATH/idProduct
echo $BCD_DEVICE > $USB_HID_PATH/bcdDevice
echo $BCD_USB > $USB_HID_PATH/bcdUSB
mkdir -p $USB_HID_PATH/strings/0x409
echo $MANUFACTURER > $USB_HID_PATH/strings/0x409/manufacturer
echo $PRODUCT > $USB_HID_PATH/strings/0x409/product
mkdir -p $USB_HID_PATH/configs/c.1
mkdir -p $USB_HID_PATH/configs/c.1/strings/0x409
echo $MAX_POWER > $USB_HID_PATH/configs/c.1/MaxPower
echo $CONFIGURATION > $USB_HID_PATH/configs/c.1/strings/0x409/configuration
mkdir -p $USB_HID_PATH/functions/hid.usb0
echo $PROTOCOL > $USB_HID_PATH/functions/hid.usb0/protocol
echo $SUBCLASS > $USB_HID_PATH/functions/hid.usb0/subclass
echo $REPORT_LENGTH > $USB_HID_PATH/functions/hid.usb0/report_length
echo -ne \\x05\\x01\\x09\\x02\\xa1\\x01\\x09\\x01\\xa1\\x00\\x05\\x09\\x19\\x01\\x29\\x05\\x15\\x00\\x25\\x01\\x95\\x05\\x75\\x01\\x81\\x02\\x95\\x01\\x75\\x03\\x81\\x01\\x05\\x01\\x09\\x30\\x09\\x31\\x09\\x38\\x15\\x81\\x25\\x7f\\x75\\x08\\x95\\x03\\x81\\x06\\xc0\\xc0 > $USB_HID_PATH/functions/hid.usb0/report_desc
ln -s $USB_HID_PATH/functions/hid.usb0 $USB_HID_PATH/configs/c.1/

#You can also try "ls /sys/class/udc > UDC" as long as /sys/class/udc contains a single interface, otherwise it wont work
echo $UDC > $USB_HID_PATH/UDC
