# Add an XBOOTLDR partition

**Priority:** High, but requires a maintenance window

**Scope:** High-risk disk operation

## Goal

Move NixOS kernels and initrds off the approximately 100 MiB EFI System
Partition (ESP) while retaining the existing Windows boot files on that ESP.

## Proposed layout

- Existing ESP: mounted at `/efi`, containing firmware bootloaders and the
  Windows EFI files.
- New 1-2 GiB FAT32 XBOOTLDR partition: mounted at `/boot`, containing NixOS
  boot entries, kernels, and initrds.
- XBOOTLDR partition type GUID:
  `bc13c2ff-59e6-4262-a352-b275fd6f7172`.

## Preparation

1. Back up important data and the current partition table.
2. Create Windows recovery media and confirm the BitLocker recovery key if
   applicable.
3. Disable Windows Fast Startup/hibernation and check the Windows filesystem.
4. Keep a NixOS live USB and a known-good generation available.
5. Confirm exact device names, partition numbers, free space, UUIDs, and mount
   points immediately before making changes.

## Plan

1. Shrink the large Windows data/system partition from Windows Disk Management
   by 1-2 GiB. Do not resize NTFS from the running NixOS installation.
2. Create a FAT32 partition in the freed space and set its XBOOTLDR type GUID.
3. Format it, copy/preserve any required NixOS boot content, and update the
   hardware/filesystem declarations using UUIDs.
4. Configure systemd-boot with the ESP at `/efi` and XBOOTLDR at `/boot`.
5. Mount both filesystems and run a boot activation.
6. Confirm entries with `bootctl`, reboot once into the new default, and retain
   recovery options until the result is proven.

## Acceptance criteria

- Windows continues to boot through the original ESP.
- NixOS kernels/initrds are stored on the XBOOTLDR partition.
- A normal kernel update and bootloader activation succeeds with ample space.
- The temporary aggressive initrd compression and very low generation limit
  can be reconsidered after the larger partition is working.
