#!/usr/bin/env bash
#
# iso2usb-macos.sh - Write an ISO image to a USB drive on macOS.
#
# Usage:
#   ./iso2usb-macos.sh [--prompt|-p] /path/to/input.iso
#
# Options:
#   -p, --prompt   Skip El Torito auto-detection and go straight to the
#                  direct-write Y/N prompt with no pre-selected default.
#
# Requires: hdiutil, diskutil, dd (all built into macOS). Must be run with
# sudo privileges for the dd step (the script will prompt when needed).

set -euo pipefail

SKIP_DETECT=0
ISO_PATH=""

while [[ $# -gt 0 ]]; do
    case "$1" in
        -p|--prompt)
            SKIP_DETECT=1
            shift
            ;;
        -*)
            echo "Unknown option: $1"
            echo "Usage: $0 [--prompt|-p] /path/to/input.iso"
            exit 1
            ;;
        *)
            ISO_PATH="$1"
            shift
            ;;
    esac
done

if [[ -z "$ISO_PATH" ]]; then
    echo "Usage: $0 [--prompt|-p] /path/to/input.iso"
    exit 1
fi

if [[ ! -f "$ISO_PATH" ]]; then
    echo "Error: file not found: $ISO_PATH"
    exit 1
fi

# List external/removable disks only, to reduce risk of selecting an internal drive.
echo "Available external disks:"
echo "--------------------------"
diskutil list external

echo ""
read -rp "Enter the disk identifier to write to (e.g. disk4): " DISK_ID

# Normalize input in case user includes /dev/ prefix.
DISK_ID="${DISK_ID#/dev/}"
DISK_PATH="/dev/${DISK_ID}"
RDISK_PATH="/dev/r${DISK_ID}"

if [[ ! -e "$DISK_PATH" ]]; then
    echo "Error: $DISK_PATH does not exist."
    exit 1
fi

DISK_INFO="$(diskutil info "$DISK_PATH")"
DISK_SIZE="$(echo "$DISK_INFO" | grep "Disk Size" | sed -E 's/.*Disk Size:[[:space:]]*//; s/[[:space:]]*\(.*//')"
# Not all diskutil info output includes a "Disk Size" field (varies by
# identifier type, e.g. whole-disk vs partition). Fall back to "Total Size"
# if the first lookup came back empty.
[[ -z "$DISK_SIZE" ]] && DISK_SIZE="$(echo "$DISK_INFO" | grep "Total Size" | sed -E 's/.*Total Size:[[:space:]]*//; s/[[:space:]]*\(.*//')"

echo ""
echo "Selected device: $DISK_PATH (${DISK_SIZE:-unknown size})"
echo "$DISK_INFO" | grep -E "Device / Media Name|Protocol|Total Size|Removable Media"

echo ""
echo "WARNING: all data on $DISK_PATH will be destroyed."
read -rp "Type the disk identifier again to confirm (e.g. disk4): " CONFIRM_ID
if [[ "$CONFIRM_ID" != "$DISK_ID" ]]; then
    echo "Confirmation did not match. Aborting."
    exit 1
fi

WORKDIR="$(mktemp -d)"
trap 'rm -rf "$WORKDIR"' EXIT

IMG_PATH=""

# Check for an El Torito boot record to determine if the ISO is hybrid.
# The boot record volume descriptor lives at sector 17 (byte offset 0x8800).
# Byte 0 of that sector is 0x00 (boot record type), followed by the string
# "CD001", followed by the boot system identifier. Hybrid/El Torito ISOs
# carry "EL TORITO SPECIFICATION" in that identifier field.
is_hybrid_iso() {
    local iso="$1"
    dd if="$iso" bs=1 skip=34823 count=23 2>/dev/null | grep -aq "EL TORITO SPECIFICATION"
}

DEFAULT_DIRECT=""
if [[ "$SKIP_DETECT" -eq 1 ]]; then
    echo "Skipping El Torito auto-detection (--prompt set)."
else
    echo "Inspecting ISO for El Torito hybrid boot support..."
    if is_hybrid_iso "$ISO_PATH"; then
        echo "Detected: hybrid El Torito/ISO9660 image. Direct dd write should work."
        DEFAULT_DIRECT="Y"
    else
        echo "No El Torito boot record found. This ISO is likely not hybrid;"
        echo "converting via hdiutil is recommended."
        DEFAULT_DIRECT="N"
    fi
fi

read -rp "Attempt direct write of the raw ISO without conversion? [${DEFAULT_DIRECT:-y/N}]: " DIRECT
DIRECT="${DIRECT:-$DEFAULT_DIRECT}"
if [[ "$DIRECT" =~ ^[Yy]$ ]]; then
    IMG_PATH="$ISO_PATH"
else
    echo "Converting ISO to UDRW image..."
    hdiutil convert -format UDRW -o "${WORKDIR}/output.img" "$ISO_PATH"
    # hdiutil appends .dmg to the output filename even though it is raw content.
    IMG_PATH="${WORKDIR}/output.img.dmg"
fi

echo "Unmounting $DISK_PATH..."
diskutil unmountDisk "$DISK_PATH"

echo "Writing image to $RDISK_PATH. This may take several minutes..."
sudo dd if="$IMG_PATH" of="$RDISK_PATH" bs=1m status=progress

echo "Ejecting $DISK_PATH..."
diskutil eject "$DISK_PATH"

echo "Done."
