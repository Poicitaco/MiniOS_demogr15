#!/bin/bash
# ============================================
# Script test Mini OS trong QEMU
# ============================================
# Mục đích: Tự động build (nếu cần) và chạy MiniOS trong QEMU
# QEMU options:
#   -cdrom: Gắn file ISO như CD-ROM
#   -boot d: Boot từ CD-ROM (d = device)
#   -m 128M: Cấp 128MB RAM cho VM
#   -name: Đặt tên cửa sổ QEMU
# Phím tắt QEMU:
#   Ctrl+Alt+G: Nhả chuột ra khỏi QEMU window
#   Ctrl+Alt+Q: Thoát QEMU
# ============================================

echo "====================================="
echo "  Test Mini OS trong QEMU"
echo "====================================="
echo ""

# Di chuyển về thư mục gốc của project
cd "$(dirname "$0")/.."

# Kiểm tra xem ISO đã build chưa
# Nếu chưa có file iso/minios.iso thì build trước
if [ ! -f "iso/minios.iso" ]; then
    echo "Không tìm thấy ISO. Đang build..."
    make
fi

echo "Đang khởi động QEMU..."
echo ""
echo "Phím tắt hữu ích:"
echo "  Ctrl+Alt+G  - Nhả chuột ra khỏi cửa sổ QEMU"
echo "  Ctrl+Alt+Q  - Thoát QEMU"
echo "  Ctrl+Alt+F  - Chế độ fullscreen"
echo ""

# Chạy QEMU với ISO
if [ -f "iso/minios.iso" ]; then
    qemu-system-i386 \
        -cdrom iso/minios.iso \
        -boot d \
        -m 128M \
        -name "Mini OS"
    # Giải thích các tham số:
    # -cdrom iso/minios.iso: Gắn ISO vào ổ CD/DVD ảo
    # -boot d: Boot từ CD-ROM (a=floppy, c=hard disk, d=CD-ROM)
    # -m 128M: Cấp 128MB RAM (MiniOS chỉ cần ít RAM)
    # -name "Mini OS": Tên hiển thị trên title bar của QEMU
else
    echo "Lỗi: Không tìm thấy file ISO!"
    echo "Vui lòng chạy 'make' trước để build OS."
    exit 1
fi
