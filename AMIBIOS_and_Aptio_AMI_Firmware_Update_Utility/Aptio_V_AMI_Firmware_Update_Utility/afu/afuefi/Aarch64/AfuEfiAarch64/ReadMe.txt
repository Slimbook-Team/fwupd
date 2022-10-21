AFU (AMI Firmware Update) is a package of utilities used to update the system BIOS

Note: AFU only works for AptioV with RuntimeFlash support.

The package includes:

- AfuEfi 5.04.02
- Release Notes
- User Guide (This document)

To run, simply extract all of the files from the zipped package.

Usage (applies to AfuEfi and AfuLnx):
------------------------------------------------------------------
AfuXxx <BIOS ROM File Name> [Command 1] [Command 2] [...]

<BIOS ROM File Name>
    The mandatory field is used to specify path/filename of the BIOS ROM file with extension.

[Commands]
    The mandatory field is used to select an operation mode.
      /CAPSULE - Runtime Capsule Update
      /ROMINFO - Dump system BIOS information
            /O - Save BIOS into specified file
            /P - Program DXE region of given ROM file
         /K[N] - Program NCB region of given ROM file
            /N - Program NVRAM region of given ROM file
            /B - Program PEI region of given ROM file
       /ECINFO - Display OEM firmware information
           /EC - Update EC Firmware by specified file
            /Q - Suppress progress output
           /SP - Force BIOS to preserve specific data
            /X - Ignore BIOS tag
            /E - Program shared firmware of given ROM file
            /L - Update all ROM hole
           /Ln - Update n-th ROM hole
     
