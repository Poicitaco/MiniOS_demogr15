#!/bin/bash
# ============================================
# Script build cho Mini OS
# ============================================
# Mục đích: Tự động hóa quá trình build MiniOS
# Các bước:
#   1. Xóa các file build cũ
#   2. Build bootloader và kernel
#   3. Tạo OS image và ISO
#   4. Hiển thị kết quả
# ============================================

echo "====================================="
echo "  Đang build Mini OS"
echo "====================================="
echo ""

# Di chuyển về thư mục gốc của project
cd "$(dirname "$0")/.."

# Xóa file build cũ
echo "Xóa file build cũ..."
rm -rf build iso

# Tạo thư mục build
echo "Tạo thư mục build..."
mkdir -p build
mkdir -p iso/boot

# Build bootloader
echo "Biên dịch bootloader..."
nasm -f bin boot/boot.asm -o build/boot.bin
if [ $? -ne 0 ]; then
    echo "LỖI: Không thể biên dịch bootloader!"
    exit 1
fi

# Build kernel
echo "Biên dịch kernel..."
if [ -f "kernel/kernel.asm" ]; then
    echo "  → Sử dụng MiniOS v3.0 kernel"
    nasm -f bin kernel/kernel.asm -o build/kernel.bin
else
    echo "  → ERROR: kernel.asm not found!"
    exit 1
fi
if [ $? -ne 0 ]; then
    echo "LỖI: Không thể biên dịch kernel!"
    exit 1
fi

# Tạo OS image
echo "Tạo OS image..."
cat build/boot.bin build/kernel.bin > build/os-image.bin
truncate -s 1440K build/os-image.bin

# Tạo ISO
echo "Tạo ISO image..."
cp build/os-image.bin iso/boot/
if command -v genisoimage >/dev/null 2>&1; then
    genisoimage -quiet -V "MiniOS" -input-charset iso8859-1 -o iso/minios.iso -b boot/os-image.bin -hide boot.catalog iso
elif command -v mkisofs >/dev/null 2>&1; then
    mkisofs -quiet -V "MiniOS" -input-charset iso8859-1 -o iso/minios.iso -b boot/os-image.bin -hide boot.catalog iso
else
    echo "CẢNH BÁO: Không tìm thấy genisoimage hoặc mkisofs, không thể tạo ISO"
    echo "Cài đặt: sudo apt install genisoimage"
fi

# Kiểm tra kết quả build
if [ -f "build/os-image.bin" ]; then
    # Build thành công
    echo ""
    echo "====================================="
    echo "  Build thành công!"
    echo "====================================="
    echo ""
    echo "Các file output:"
    echo "  • build/boot.bin        - Bootloader (512 bytes)"
    echo "  • build/kernel.bin      - Kernel GUI (Assembly)"
    echo "  • build/os-image.bin    - OS image hoàn chỉnh (raw disk image)"
    echo "  • iso/minios.iso        - File ISO bootable"
    echo ""
    echo "Để test trong QEMU:"
    echo "  make run        (chạy raw image)"
    echo "  make run-iso    (chạy ISO image)"
    echo ""
    echo "Để dùng trong VirtualBox/VMware:"
    echo "  1. Tạo máy ảo mới (VM)"
    echo "  2. Thêm iso/minios.iso làm CD/DVD"
    echo "  3. Boot từ CD/DVD"
    echo ""
else
    # Build thất bại
    echo ""
    echo "====================================="
    echo "  Build thất bại!"
    echo "====================================="
    echo ""
    echo "Vui lòng kiểm tra các lỗi ở trên."
    exit 1
fi
