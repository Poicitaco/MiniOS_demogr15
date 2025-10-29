#!/bin/bash
# =====================================================
# Script tự động tạo VM VirtualBox cho MiniOS
# =====================================================

set -e  # Exit on error

VM_NAME="MiniOS_v4"
VM_DIR="$HOME/VirtualBox VMs/$VM_NAME"
OS_IMAGE="$(cd "$(dirname "$0")/.." && pwd)/build/minios.img"
VBOX_MANAGE="/mnt/c/Program Files/Oracle/VirtualBox/VBoxManage.exe"

echo "====================================="
echo "  Setup VirtualBox VM cho MiniOS"
echo "====================================="
echo ""

# Kiểm tra VBoxManage
if [ ! -f "$VBOX_MANAGE" ]; then
    echo "❌ Không tìm thấy VBoxManage.exe"
    echo "   Đường dẫn: $VBOX_MANAGE"
    echo ""
    echo "Vui lòng cài đặt VirtualBox hoặc sửa đường dẫn trong script."
    exit 1
fi

# Kiểm tra file VDI
if [ ! -f "$OS_IMAGE" ]; then
    echo "❌ Không tìm thấy file minios.img"
    echo "   Đường dẫn: $OS_IMAGE"
    echo ""
    echo "Vui lòng chạy ./scripts/build.sh trước để tạo file IMG."
    exit 1
fi

echo "✓ Tìm thấy VBoxManage"
echo "✓ Tìm thấy minios.img"
echo ""

# Xóa VM cũ nếu tồn tại
echo "Kiểm tra VM cũ..."
if "$VBOX_MANAGE" list vms | grep -q "\"$VM_NAME\""; then
    echo "  → Tìm thấy VM '$VM_NAME' cũ, đang xóa..."
    "$VBOX_MANAGE" unregistervm "$VM_NAME" --delete 2>/dev/null || true
    echo "  → Đã xóa VM cũ"
fi
echo ""

# Tạo VM mới
echo "Tạo VM mới: $VM_NAME"
"$VBOX_MANAGE" createvm --name "$VM_NAME" --ostype "Other" --register

# Cấu hình VM
echo "Cấu hình VM..."
"$VBOX_MANAGE" modifyvm "$VM_NAME" \
    --memory 128 \
    --vram 16 \
    --cpus 1 \
    --boot1 disk \
    --boot2 none \
    --boot3 none \
    --boot4 none \
    --audio none \
    --usb off \
    --rtcuseutc on

# Tạo Storage Controller - SỬA DỤNG FLOPPY
echo "Tạo Floppy Controller..."
"$VBOX_MANAGE" storagectl "$VM_NAME" \
    --name "Floppy Controller" \
    --add floppy \
    --bootable on

# Convert đường dẫn WSL sang Windows - SỬA DỤNG OS-IMAGE.BIN
WIN_IMG_PATH=$(wslpath -w "$OS_IMAGE")

# Attach floppy disk
echo "Attach floppy: $WIN_IMG_PATH"
"$VBOX_MANAGE" storageattach "$VM_NAME" \
    --storagectl "Floppy Controller" \
    --port 0 \
    --device 0 \
    --type fdd \
    --medium "$WIN_IMG_PATH"

echo ""
echo "====================================="
echo "  ✓ VM đã được tạo thành công!"
echo "====================================="
echo ""
echo "Thông info VM:"
echo "  • Tên: $VM_NAME"
echo "  • RAM: 128 MB"
echo "  • Disk: minios.img (1.44 MB floppy)"
echo "  • OS Type: Other"
echo ""
echo "Cách sử dụng:"
echo "  1. Mở VirtualBox Manager"
echo "  2. Chọn VM '$VM_NAME'"
echo "  3. Click 'Start' (mũi tên xanh)"
echo ""
echo "Hoặc chạy ngay từ terminal:"
echo "  \"$VBOX_MANAGE\" startvm \"$VM_NAME\""
echo ""
