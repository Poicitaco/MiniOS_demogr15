#!/bin/bash
# =====================================================
# Script tạo VDI bootable cho VirtualBox
# =====================================================

set -e

BUILD_DIR="$(cd "$(dirname "$0")/.." && pwd)/build"
OS_IMAGE="$BUILD_DIR/os-image.bin"
VDI_FILE="$BUILD_DIR/minios_boot.vdi"
VBOX_MANAGE="/mnt/c/Program Files/Oracle/VirtualBox/VBoxManage.exe"

echo "====================================="
echo "  Tạo VDI bootable cho VirtualBox"
echo "====================================="
echo ""

# Kiểm tra file
if [ ! -f "$OS_IMAGE" ]; then
    echo "❌ Không tìm thấy $OS_IMAGE"
    echo "   Vui lòng chạy ./scripts/build.sh trước"
    exit 1
fi

echo "✓ Tìm thấy os-image.bin"
echo ""

# Xóa VDI cũ
echo "Xóa VDI cũ (nếu có)..."
rm -f "$VDI_FILE"

# Tạo VDI mới với UUID ngẫu nhiên
echo "Tạo VDI mới..."
UUID=$(cat /proc/sys/kernel/random/uuid 2>/dev/null || uuidgen)
"$VBOX_MANAGE" convertfromraw "$OS_IMAGE" "$VDI_FILE" --format VDI --uuid "$UUID"

# Set bootable flag
echo "Cấu hình bootable..."
"$VBOX_MANAGE" modifymedium disk "$VDI_FILE" --type normal

echo ""
echo "====================================="
echo "  ✓ VDI đã được tạo thành công!"
echo "====================================="
echo ""
echo "File: $VDI_FILE"
echo "UUID: $UUID"
echo ""
echo "Chạy setup-virtualbox.sh để tạo VM"
echo ""
