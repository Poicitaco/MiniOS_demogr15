#!/bin/bash
# ============================================
# Script test Mini OS trong QEMU với Curses Mode
# ============================================
# Curses mode: Chạy QEMU trong terminal thay vì cửa sổ riêng
# Ưu điểm: Font terminal tốt hơn, có thể hiện tiếng Việt đúng
# Nhược điểm: Không có chuột, chỉ bàn phím
# ============================================

echo "====================================="
echo "  Test Mini OS trong QEMU (Curses)"
echo "====================================="
echo ""

# Kiểm tra file ISO
if [ ! -f "iso/minios.iso" ]; then
    echo "⚠️  Không tìm thấy iso/minios.iso"
    echo "Đang build..."
    ./scripts/build.sh
    echo ""
fi

echo "🚀 Khởi động QEMU trong terminal mode..."
echo ""
echo "Lưu ý:"
echo "  - Chạy trong terminal (không mở cửa sổ mới)"
echo "  - Font terminal nên hiển thị tiếng Việt tốt hơn"
echo "  - ESC + 2 để vào QEMU monitor"
echo "  - ESC + 1 để về console"
echo "  - Ctrl+A, X để thoát"
echo ""
echo "Nhấn Enter để tiếp tục..."
read

# Chạy QEMU với curses mode
qemu-system-i386 \
    -drive format=raw,file=build/os-image.bin \
    -m 128M \
    -name "MiniOS v4.0 (Terminal Mode)" \
    -curses

echo ""
echo "✅ QEMU đã thoát"
