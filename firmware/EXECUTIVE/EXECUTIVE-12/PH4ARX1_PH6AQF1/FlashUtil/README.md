We have this file: [PHxAQFxN105GRU05.BIN](https://github.com/Slimbook-Team/fwupd/blob/fwupd_files/firmware/EXECUTIVE/EXECUTIVE-12/PH4ARX1_PH6AQF1/FlashUtil/ROM/PHxAQFxN105GRU05.BIN)

1. We generate a <b>firmware.cap</b> file from this binary file using the [add_capsule_header.py](https://github.com/fwupd/fwupd/blob/main/contrib/firmware_packager/add_capsule_header.py) from the fwupd repository.


2. We add an xml to generate the .cab file:
      <details close>
      <summary><b>firmware.metainfo.xml</b></summary>

      ```xml
      <?xml version='1.0' encoding='utf-8'?>
      <component type="firmware">
        <id>es.slimbook.executive.intel.12.firmware</id>
        <name>Intel Executive 12 Series</name>
        <summary>BIOS update slimbook</summary>
        <description>
          <p>Improvements made to bios features</p>
        </description>
        <provides>
          <firmware type="flashed">d1f93b23-9f97-5b9d-8547-2cdd203e17a5</firmware>
        </provides>
        <url type="homepage">https://slimbook.es</url>
        <metadata_license>CC0-1.0</metadata_license>
        <project_license>LicenseRef-proprietary</project_license>
        <categories>
          <category>X-System</category>
        </categories>
        <custom>
          <value key="LVFS::VersionFormat">plain</value>
          <value key="LVFS::UpdateProtocol">org.uefi.capsule</value>
        </custom>
        <releases>
          <release version="105" date="2022-09-24" urgency="high">
            <checksum filename="firmware.cap" target="content"/>
            <description>
              <p>This stable release fixes the following issues:</p>
              <ul>
                <li>Improvements made to older bios versions</li>
              </ul>
            </description>
          </release>
        </releases>
      </component>

      ```
      </details>

3. Then we generate firmware.cab using:
`gcab --create firmware.cab firmware.cap firmware.metainfo.xml`

    This works fine to upload firmware tol lvfs, but downloading the [signed .cab](https://fwupd.org/lvfs/firmware/13906) from lvfs and installing it gives us this error:
      <details close>
      <summary><b>sudo fwupdtool get-history</b> (remains after reboot)</summary>

      ```shell
      slimbook@slimbook-Executive14i12:~$ sudo fwupdtool get-history 
      [sudo] password for slimbook: 
      Loading…                [-                                      ]
      14:19:10:0093 FuEngine             failed to get releases for UEFI Device Firmware: No releases found: no HWIDs matched c58fd9e0-fdcb-5143-8b8d-067f49616186|0f5747db-b74f-5dd0-aa68-0ed55b96b2c4
      14:19:10:0094 FuEngine             failed to get releases for Intel Management Engine: No releases found: no HWIDs matched c58fd9e0-fdcb-5143-8b8d-067f49616186|0f5747db-b74f-5dd0-aa68-0ed55b96b2c4
      14:19:12:0989 FuEngine             failed to update history database: Error opening file /sys/firmware/efi/efivars/CapsuleLast-39b68c46-f7fb-441b-b6ec-16b0f69821f3: No existe el archivo o el directorio
      Loading…                [***************************************]
      Executive14i12
      │
      └─System Firmware:
        │   Device ID:          a45df35ac0e948ee180fe216a5f703f32dda163f
        │   Previous version:   100
        │   Update State:       Needs reboot
        │   Last modified:      2022-10-24 14:12
        │   GUID:               d1f93b23-9f97-5b9d-8547-2cdd203e17a5
        │   Device Flags:       • Internal device
        │                       • Updatable
        │                       • System requires external power source
        │                       • Needs a reboot after installation
        │                       • Cryptographic hash verification is available
        │                       • Device is usable for the duration of the update
        │ 
        └─  New version:      105
              License:          Unknown
              Description:      
              The vendor did not supply any release notes.
      ```
      </details>

      

      <details close>
      <summary><b>sudo fwupdtool get-devices</b> (authentication signing error)</summary>

      ```shell
      slimbook@slimbook-Executive14i12:~$ sudo fwupdtool get-devices 
      ...

      ├─System Firmware:
      │ │   Device ID:          a45df35ac0e948ee180fe216a5f703f32dda163f
      │ │   Summary:            UEFI ESRT device
      │ │   Current version:    100
      │ │   Minimum Version:    100
      │ │   Vendor:             SLIMBOOK (DMI:American Megatrends International, LLC.)
      │ │   Update State:       Failed
      │ │   Update Error:       failed to update to 0: authentication signing error
      │ │   GUID:               d1f93b23-9f97-5b9d-8547-2cdd203e17a5
      │ │                       230c8b18-8d9b-53ec-838b-6cfc0383493a ← main-system-firmware
      │ │                       3b76b318-be82-5bc6-9044-ad376f4ff046 ← UEFI\RES_{D1F93B23-9F97-5B9D-8547-2CDD203E17A5}
      │ │   Device Flags:       • Internal device
      │ │                       • Updatable
      │ │                       • System requires external power source
      │ │                       • Needs a reboot after installation
      │ │                       • Cryptographic hash verification is available
      │ │                       • Device is usable for the duration of the update


      ```
      </details>
      
      
      
      <details close>
      <summary><b>sudo fwupdtool install-blob 39fcfdd0d6d1396fe970aca9ada148aebbdab3c1a8f203382ef804fdd3c87d76-105.cab</b> ()</summary>

      ```shell
      slimbook@slimbook-Executive14i12:~/Escritorio$ sudo fwupdtool install-blob 39fcfdd0d6d1396fe970aca9ada148aebbdab3c1a8f203382ef804fdd3c87d76-105.cab
      Loading…                [-                                      ]
      14:43:44:0654 FuEngine             failed to get releases for UEFI Device Firmware: No releases found: no HWIDs matched c58fd9e0-fdcb-5143-8b8d-067f49616186|0f5747db-b74f-5dd0-aa68-0ed55b96b2c4
      14:43:44:0655 FuEngine             failed to get releases for Intel Management Engine: No releases found: no HWIDs matched c58fd9e0-fdcb-5143-8b8d-067f49616186|0f5747db-b74f-5dd0-aa68-0ed55b96b2c4
      14:43:47:0520 FuEngine             failed to update history database: Error al abrir el archivo /sys/firmware/efi/efivars/CapsuleLast-39b68c46-f7fb-441b-b6ec-16b0f69821f3: No existe el archivo o el directorio
      Loading…                [***************************************]
      Choose a device:
      0.	Cancel
      1.	4bde70ba4e39b28f9eab1628f9dd6e6244c03027 (12th Gen Intel Core™ i7-12700H)
      2.	3743975ad7f64f8d6575a9ae49fb3a8856fe186f (CT250P2SSD8)
      3.	5792b48846ce271fab11c4a545f7a3df0d36e00a (Display controller)
      4.	ce4c74a5188d5b9cdb1e72ed32dad2d313c1c999 (GA107M [GeForce RTX 3050 Ti Mobile])
      5.	f95c9218acd12697af946874bfe4239587209232 (Intel Management Engine)
      6.	a45df35ac0e948ee180fe216a5f703f32dda163f (System Firmware)
      7.	c6a80ac3a22083423992a3cb15018989f37834d6 (TPM)
      8.	349bb341230b1a86e5effe7dfe4337e1590227bd (UEFI Device Firmware)
      9.	2292ae5236790b47884e37cf162dcf23bfcd1c60 (UEFI Device Firmware)
      10.	d96de5c124b60ed6241ebcb6bb2c839cb5580786 (UEFI Device Firmware)
      11.	362301da643102b9f38477387e2193e57abaa590 (UEFI dbx)
      12.	3746495ae28b17bef982ccce498b9a456bea6ff3 (USB4 host controller)
      6 
      Descomprimiendo…         [ -                                     ]failed to read EFI variable: Error opening file /sys/firmware/efi/efivars/OsIndications-8be4df61-93ca-11d2-aa0d-00e098032b8c: The file or directory does not exist

      ```
      </details>
      In this last error, /sys/firmware/efi/efivars/<b>OsIndicationsSupported</b>-8be4df61-93ca-11d2-aa0d-00e098032b8c exists, but only ...OsIndications...  does not.
      
Fwupd version:
------
```
runtime   org.freedesktop.fwupd         1.7.5
runtime   com.dell.libsmbios            2.4
compile   org.freedesktop.gusb          0.3.10
runtime   org.kernel                    5.15.0-52-generic
compile   org.freedesktop.fwupd         1.7.5
runtime   org.freedesktop.gusb          0.3.10
```

Aditional information:
----------------
Building .cap with .rom file, and installing it without uploading to LVFS gives me this error: `failed to update to 0: invalid firmware format`

We can manually update BIOS and EC using this file [F.nsh](https://github.com/Slimbook-Team/fwupd/blob/fwupd_files/firmware/EXECUTIVE/EXECUTIVE-12/PH4ARX1_PH6AQF1/FlashUtil/AfuEfi64Cap/F.nsh), the binary and the rom file in that linked directory.
