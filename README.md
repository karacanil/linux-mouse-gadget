Linux Mouse Gadget
===============

mouse-gadget is a shell script that sets up a simple HID mouse
gadget via ConfigFS.

Usage
-----
```shell
# ./mouse-gadget.sh
# or
# sh mouse-gadget.sh
```

After running the script you can write HID reports to ```/dev/hidg<xx>```, a device file
created when the ConfigFS gadget is bound to the UDC driver.

Dependencies
------------
* ConfigFS support must be enabled in the kernel. This must be done at kernel
  build time. It's usually enabled by default, though.

* HID support (f_hid) was added in kernel 3.19, so you need >= 3.19 to use ConfigFS
  to build HID gadgets (and subsequently use this script).
