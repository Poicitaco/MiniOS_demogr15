#!/bin/bash
# ============================================
# Script build cho Mini OS
# ============================================
# Mục đích: Tự động hóa quá trình build MiniOS
# Các bước:
#   1. Xóa các file build cũ (make clean)
#   2. Build lại toàn bộ (make all)
#   3. Hiển thị kết quả và hướng dẫn sử dụng
# ============================================

echo "====================================="
echo "  Đang build Mini OS"
echo "====================================="
echo ""

# Di chuyển về thư mục gốc của project
# $(dirname "$0") = thư mục chứa script này (scripts/)
# /.. = lên thư mục cha (MiniOS/)
cd "$(dirname "$0")/.."

# Chạy make clean để xóa file build cũ, sau đó make all để build mới
make clean
make all

# Kiểm tra kết quả build ($? = exit code của lệnh trước đó)
if [ $? -eq 0 ]; then
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
