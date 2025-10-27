## Makefile cho Mini OS
## ------------------------------------------------------
## Mục tiêu:
##  - Biên dịch bootloader (512 bytes) và kernel (Assembly GUI) thành ảnh đĩa
##  - Tạo file ISO bootable để chạy trên máy ảo hoặc máy thật
## Ghi chú:
##  - Hiện tại chỉ dùng kernel GUI (kernel_gui.asm) viết hoàn toàn bằng Assembly
##  - Mã CLI/C cũ đã được chuyển vào thư mục legacy/ và không build nữa
##  - Các lệnh QEMU chỉ chạy được nếu đã cài qemu-system-i386
																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																										`																																			
# ============================================
# CÔNG CỤ BIÊN DỊCH
# ============================================
ASM = nasm          # Trình biên dịch Assembly (NASM)
CC = gcc            # Trình biên dịch C (không dùng trong build hiện tại)
LD = ld             # Trình liên kết (không dùng trong build hiện tại)

# ============================================
# CÁC CỜ BIÊN DỊCH
# ============================================
ASMFLAGS = -f elf   # Format ELF cho NASM (không dùng cho binary thuần)
# Các cờ cho GCC khi biên dịch kernel C (hiện không dùng):
CFLAGS = -m32 -ffreestanding -fno-pie -nostdlib -nostdinc -fno-builtin -fno-stack-protector -Wall -Wextra
# Các cờ cho linker khi liên kết kernel (hiện không dùng):
LDFLAGS = -m elf_i386 -Ttext 0x1000 --oformat binary

# ============================================
# THư MỤC
# ============================================
BUILD_DIR = build   # Thư mục chứa file build (boot.bin, kernel.bin, os-image.bin)
ISO_DIR = iso       # Thư mục chứa file ISO cuối cùng

# ============================================
# FILE NGUỒN (SOURCE FILES)
# ============================================
BOOT_SRC = boot/boot.asm                # Bootloader - 512 bytes đầu tiên, load kernel vào RAM
KERNEL_ENTRY_SRC = kernel/kernel_gui.asm # Kernel GUI hoàn chỉnh viết bằng Assembly

## Các file kernel C cũ (đã chuyển vào legacy/, không build):
# KERNEL_CSRC = kernel/kernel.c kernel/screen.c kernel/keyboard.c

# ============================================
# FILE OBJECT VÀ OUTPUT
# ============================================
BOOT_BIN = $(BUILD_DIR)/boot.bin          # Bootloader đã biên dịch (512 bytes)
KERNEL_ENTRY_OBJ = $(BUILD_DIR)/kernel_entry.o # Kernel đã biên dịch (binary thuần)

## File object C (không dùng):
# KERNEL_OBJS = $(BUILD_DIR)/kernel.o $(BUILD_DIR)/screen.o $(BUILD_DIR)/keyboard.o

# ============================================
# FILE OUTPUT CUỐI CÙNG
# ============================================
KERNEL_BIN = $(BUILD_DIR)/kernel.bin      # Kernel binary (copy từ kernel_entry.o)
OS_IMAGE = $(BUILD_DIR)/os-image.bin      # OS image hoàn chỉnh (boot.bin + kernel.bin)
ISO_IMAGE = $(ISO_DIR)/minios.iso         # File ISO bootable

# ============================================
# TARGET MẶC ĐỊNH
# ============================================
# Khi chạy "make" không có tham số, sẽ build ISO
all: directories $(ISO_IMAGE)

# ============================================
# TẠO THƯ MỤC BUILD VÀ ISO
# ============================================
directories:
	@mkdir -p $(BUILD_DIR)  # Tạo thư mục build/ nếu chưa có
	@mkdir -p $(ISO_DIR)    # Tạo thư mục iso/ nếu chưa có

# ============================================
# BIÊN DỊCH BOOTLOADER
# ============================================
# Bootloader là sector đầu tiên (512 bytes) của đĩa
# BIOS sẽ load 512 bytes này vào địa chỉ 0x7C00 và chạy
# Bootloader có nhiệm vụ load kernel từ đĩa vào RAM
$(BOOT_BIN): $(BOOT_SRC)
	@echo "Đang biên dịch bootloader..."
	$(ASM) -f bin $< -o $@  # -f bin: tạo file binary thuần (không có header)

# ============================================
# BIÊN DỊCH KERNEL GUI
# ============================================
# Kernel GUI là chương trình chính của OS, viết hoàn toàn bằng Assembly
# Kernel sẽ được bootloader load vào địa chỉ 0x1000 trong RAM
# Kernel chứa: GUI, menu, calculator, text editor, file manager, v.v.
$(KERNEL_ENTRY_OBJ): kernel/kernel_gui.asm
	@echo "Đang biên dịch kernel GUI..."
	$(ASM) -f bin $< -o $@  # -f bin: tạo file binary thuần

# LƯU Ý: Các file kernel C đã được archive vào legacy/ và không build trong cấu hình hiện tại

# ============================================
# CHUẨN BỊ KERNEL BINARY
# ============================================
# Copy kernel_entry.o thành kernel.bin (chỉ đổi tên cho dễ hiểu)
# Vì kernel hiện tại đã là all-in-one (tất cả trong 1 file .asm)
$(KERNEL_BIN): $(KERNEL_ENTRY_OBJ)
	@echo "Đang chuẩn bị kernel..."
	cp $< $@  # Copy kernel_entry.o -> kernel.bin

# ============================================
# TẠO OS IMAGE HOÀN CHỈNH
# ============================================
# Ghép bootloader (512 bytes) + kernel thành 1 file image
# Cấu trúc: [boot.bin][kernel.bin]
# - Sector 0 (512 bytes đầu): bootloader
# - Từ sector 1 trở đi: kernel code
$(OS_IMAGE): $(BOOT_BIN) $(KERNEL_BIN)
	@echo "Đang tạo OS image..."
	cat $^ > $@  # Ghép boot.bin và kernel.bin thành os-image.bin
	@# Padding đến đúng kích thước đĩa mềm 1.44MB (1440KB)
	@# Điều này đảm bảo image có kích thước chuẩn cho floppy disk
	@truncate -s 1440K $@

# ============================================
# TẠO FILE ISO BOOTABLE
# ============================================
# ISO là định dạng CD-ROM, dễ boot trên máy ảo hơn raw image
# ISO chứa os-image.bin trong thư mục boot/
$(ISO_IMAGE): $(OS_IMAGE)
	@echo "Đang tạo ISO image..."
	@mkdir -p $(ISO_DIR)/boot  # Tạo thư mục boot/ trong ISO
	@cp $< $(ISO_DIR)/boot/     # Copy os-image.bin vào ISO/boot/
	@# Tạo ISO bằng genisoimage hoặc mkisofs (2 công cụ tương đương)
	@# -V "MiniOS": tên volume của ISO
	@# -input-charset iso8859-1: encoding ký tự
	@# -b boot/os-image.bin: file bootable
	@# -hide boot.catalog: ẩn file catalog không cần thiết
	@if command -v genisoimage >/dev/null 2>&1; then \
		genisoimage -quiet -V "MiniOS" -input-charset iso8859-1 -o $@ -b boot/os-image.bin -hide boot.catalog $(ISO_DIR); \
	elif command -v mkisofs >/dev/null 2>&1; then \
		mkisofs -quiet -V "MiniOS" -input-charset iso8859-1 -o $@ -b boot/os-image.bin -hide boot.catalog $(ISO_DIR); \
	else \
		echo "Lỗi: Không tìm thấy genisoimage hoặc mkisofs. Cài đặt bằng: sudo apt install genisoimage"; \
		exit 1; \
	fi
	@echo "ISO đã tạo: $(ISO_IMAGE)"

# ============================================
# CHẠY TRONG QEMU (RAW IMAGE)
# ============================================
# Chạy trực tiếp os-image.bin trong QEMU (giả lập đĩa cứng)
run: $(OS_IMAGE)
	@echo "Đang chạy trong QEMU..."
	@if command -v qemu-system-i386 >/dev/null 2>&1; then \
		qemu-system-i386 -drive file=$(OS_IMAGE),format=raw; \
	else \
		echo "QEMU chưa cài. Cài đặt bằng: sudo apt install qemu-system-x86"; \
	fi

# ============================================
# CHẠY ISO TRONG QEMU
# ============================================
# Chạy file ISO trong QEMU (giả lập CD-ROM)
# Cách này giống với boot từ CD/DVD thật
run-iso: $(ISO_IMAGE)
	@echo "Đang chạy ISO trong QEMU..."
	@if command -v qemu-system-i386 >/dev/null 2>&1; then \
		qemu-system-i386 -cdrom $(ISO_IMAGE); \
	else \
		echo "QEMU chưa cài. Cài đặt bằng: sudo apt install qemu-system-x86"; \
	fi

# ============================================
# XÓA CÁC FILE BUILD
# ============================================
clean:
	@echo "Đang xóa các file build..."
	rm -rf $(BUILD_DIR) $(ISO_DIR)  # Xóa thư mục build/ và iso/

# ============================================
# HIỂN THỊ TRỢ GIÚP
# ============================================
help:
	@echo "Hệ thống Build cho Mini OS"
	@echo "=========================="
	@echo "Các target:"
	@echo "  all       - Build OS image và ISO (mặc định)"
	@echo "  run       - Build và chạy trong QEMU (raw image)"
	@echo "  run-iso   - Build và chạy ISO trong QEMU"
	@echo "  clean     - Xóa tất cả file build"
	@echo "  help      - Hiển thị trợ giúp này"
	@echo ""
	@echo "Cấu trúc build:"
	@echo "  1. boot.asm -> boot.bin (512 bytes bootloader)"
	@echo "  2. kernel_gui.asm -> kernel.bin (kernel GUI hoàn chỉnh)"
	@echo "  3. boot.bin + kernel.bin -> os-image.bin"
	@echo "  4. os-image.bin -> minios.iso (ISO bootable)"

# ============================================
# PHONY TARGETS
# ============================================
# Các target này không tạo file thật, chỉ là lệnh
.PHONY: all directories run run-iso clean help

