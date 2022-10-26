> **Binary files used can be found in FlashUtil directory**

### BIOS Update seems to work
Here is the [LVFS firmware](https://fwupd.org/lvfs/firmware/13824) that seems to work well on a clean install. (Yo must be logged in to see it.)

It updates the BIOS but not the EC, EC might have to be updated separately.

So, the last time we talked about this, you mentioned the superio plugin.

### Super I/O problem

We need EC device to show on fwupdmgr get-devices in order to be able to update it via fwud, but fwupdtool does not detect any device with the plugin:

Output of:  `sudo fwupdtool get-devices --plugins superio -v`

```
07:57:41:0198 FuEngine             Emitting PropertyChanged('Status'='loading')
07:57:41:0198 FuPlugin             coldplug(superio)
07:57:41:0201 FuDevice             using 14362b5eaa256cd54e4991f11fe97fdc47800e97 for /dev/port:FuSuperioIt85Device
07:57:41:0451 FuEngine             disabling plugin because: failed to coldplug using superio: failed to get EC name: timed out whilst waiting for 0x01:1
07:57:41:0483 FuEngine             Emitting PropertyChanged('Status'='idle')
07:57:41:0483 FuEngine             writing motd target /var/cache/fwupd/motd.d/85-fwupd
No detected devices
07:57:41:0483 FuMain               No detected devices
```

This is the error: `failed to get EC name: timed out whilst waiting for 0x01:1`

Error code is defined here:  
[fwupd/plugins/superio/fu-superio-it85-device.c](https://github.com/fwupd/fwupd/blob/5fcfe7f0fc8cb836a93713cae34f5ba64af8ee69/plugins/superio/fu-superio-it85-device.c#L59)
Why does this happen?


## This is what I added to /usr/share/fwupd/quirks.d/superio.quirk
```
## Slimbook 2
[b71274b6-0a5f-543c-964d-2d125a6959c2]
SuperioGType = FuSuperioIt85Device
[SUPERIO\GUID_b71274b6-0a5f-543c-964d-2d125a6959c2]
SuperioId = 0x8528
SuperioPort = 0x6e
```

> **I got the GUID from: `sudo fwupdtool hwids` (as you told me)**
```
Identified face as slimbookComputer Information

BiosVendor: American Megatrends International, LLC.
BiosVersion: N.1.06GRU06
BiosMajorRelease: 5
BiosMinorRelease: 19
FirmwareMajorRelease: 01
FirmwareMinorRelease: 0e
Manufacturer: SLIMBOOK
Family: LUCIENNE
ProductName: PROX-AMD5
ProductSku: 1
EnclosureKind: a
BaseboardManufacturer: SLIMBOOK
BaseboardProduct: SLIMBOOK

Hardware IDs

{b7b6bd21-8fa1-5d02-bbc2-9ee2e7dd7c30}   <- Manufacturer + Family + ProductName + ProductSku + BiosVendor + BiosVersion + BiosMajorRelease + BiosMinorRelease
{34bc44cd-62be-5ef6-9962-26d2d8c9439f}   <- Manufacturer + Family + ProductName + BiosVendor + BiosVersion + BiosMajorRelease + BiosMinorRelease
{2fc09c2d-5dae-5ef9-9ffd-9f09d14e5137}   <- Manufacturer + ProductName + BiosVendor + BiosVersion + BiosMajorRelease + BiosMinorRelease
{74cd6b60-56e9-5573-be53-d163560fff9b}   <- Manufacturer + Family + ProductName + ProductSku + BaseboardManufacturer + BaseboardProduct
{5fcc81bd-d297-5712-b7cc-3bfa76675375}   <- Manufacturer + Family + ProductName + ProductSku
{7623b1e6-fdf8-5740-bc43-613d28815ff4}   <- Manufacturer + Family + ProductName
{b71274b6-0a5f-543c-964d-2d125a6959c2}   <- Manufacturer + ProductSku + BaseboardManufacturer + BaseboardProduct
{c0595f5a-06e3-5af2-9079-f15c7b0a7ad1}   <- Manufacturer + ProductSku
{3249003d-ea01-5f9f-aaf1-4c94f3e36a63}   <- Manufacturer + ProductName + BaseboardManufacturer + BaseboardProduct
{46e8e31d-a9f8-51d9-a93b-bfdaa99e3876}   <- Manufacturer + ProductName
{c7aa4728-f133-542e-8037-5391a1536dda}   <- Manufacturer + Family + BaseboardManufacturer + BaseboardProduct
{ef6e573f-4f06-545f-a236-b421f5b15805}   <- Manufacturer + Family
{eb94a862-0e78-5b63-91d3-c577bf66fc7f}   <- Manufacturer + EnclosureKind
{a8b3cb8b-ff31-5100-91ce-2575340330db}   <- Manufacturer + BaseboardManufacturer + BaseboardProduct
{50006923-f8ff-5601-9e59-c4e0c852297f}   <- Manufacturer
```
> **I got SuperIO info from: `sudo superiotool`**
```
superiotool r4.18
Found ITE IT8528 (id=0x8528, rev=0xa) at 0x6e
```

Fwupd version information
--------------
```shell
fwupdmgr --version
runtime   org.freedesktop.fwupd         1.7.5
runtime   com.dell.libsmbios            2.4
compile   org.freedesktop.gusb          0.3.10
runtime   org.kernel                    5.15.0-50-generic
compile   org.freedesktop.fwupd         1.7.5
runtime   org.freedesktop.gusb          0.3.10
```
