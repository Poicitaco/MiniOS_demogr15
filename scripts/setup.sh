#!/bin/bash
# ============================================
# Script cài đặt môi trường phát triển Mini OS
# ============================================
# Mục đích: Tự động cài đặt tất cả công cụ cần thiết
# Yêu cầu: Ubuntu/Debian hoặc WSL (Windows Subsystem for Linux)
# Các công cụ được cài:
#   - NASM: Trình biên dịch Assembly
#   - GCC: Trình biên dịch C (cho future development)
#   - Build tools: make, binutils, v.v.
#   - QEMU: Máy ảo để test OS
#   - genisoimage: Tạo file ISO bootable
# ============================================

echo "====================================="
echo "  Script Cài đặt Mini OS"
echo "====================================="
echo ""

# Kiểm tra xem có đang chạy trong WSL không
if grep -qi microsoft /proc/version; then
    echo "✓ Đang chạy trong WSL (Windows Subsystem for Linux)"
else
    echo "⚠ Không chạy trong WSL, nhưng vẫn tiếp tục..."
fi

echo ""
echo "Đang cài đặt các package cần thiết..."
echo ""

# Cập nhật danh sách package từ repository
# Điều này đảm bảo bạn cài phiên bản mới nhất
sudo apt update

# Cài đặt NASM - Netwide Assembler
# Dùng để biên dịch boot.asm và kernel_gui.asm thành binary
echo "Đang cài NASM assembler..."
sudo apt install -y nasm

# Cài đặt GCC - GNU Compiler Collection
# Hiện tại không dùng, nhưng giữ lại cho tương lai nếu viết code C
echo "Đang cài GCC compiler..."
sudo apt install -y gcc

# Cài đặt build-essential: make, g++, và các tool cơ bản
echo "Đang cài build tools..."
sudo apt install -y build-essential

# Cài đặt QEMU - Quick EMUlator
# Máy ảo để test OS mà không cần reboot máy thật
# qemu-system-x86: Giả lập kiến trúc x86/x86_64
echo "Đang cài QEMU emulator..."
sudo apt install -y qemu-system-x86

# Cài đặt genisoimage - Công cụ tạo ISO image
# Dùng để tạo file .iso từ os-image.bin
echo "Đang cài công cụ tạo ISO..."
sudo apt install -y genisoimage

# Cài đặt binutils - Binary utilities
# Chứa các công cụ như ld (linker), objdump, v.v.
echo "Đang cài binutils..."
sudo apt install -y binutils

echo ""
echo "====================================="
echo "  Cài đặt hoàn tất!"
echo "====================================="
echo ""
echo "Các công cụ đã cài:"
echo "  • NASM         - Trình biên dịch Assembly"
echo "  • GCC          - Trình biên dịch C"
echo "  • Make         - Công cụ build automation"
echo "  • LD           - Linker (liên kết các object file)"
echo "  • QEMU         - Máy ảo để test OS"
echo "  • genisoimage  - Tạo file ISO bootable"
echo "  • binutils     - Các công cụ xử lý binary"
echo ""
echo "Bạn có thể build Mini OS bằng lệnh:"
echo "  make              # Build tất cả"
echo "  make clean        # Xóa file build cũ"
echo "  ./scripts/build.sh # Build với script"
echo ""
echo "Chạy trong QEMU:"
echo "  make run          # Chạy raw image"
echo "  make run-iso      # Chạy ISO image"
echo ""
echo "Để xem trợ giúp:"
echo "  make help"
echo ""
