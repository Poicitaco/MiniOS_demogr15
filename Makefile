ASM = nasm
BUILD_DIR = build
ISO_DIR = iso
BOOT_SRC = boot/boot.asm
KERNEL_SRC = kernel/kernel_gui.asm
BOOT_BIN = $(BUILD_DIR)/boot.bin
KERNEL_ENTRY_OBJ = $(BUILD_DIR)/kernel_entry.o
KERNEL_BIN = $(BUILD_DIR)/kernel.bin
OS_IMAGE = $(BUILD_DIR)/os-image.bin
ISO_IMAGE = $(ISO_DIR)/minios.iso

all: directories $(ISO_IMAGE)

directories:
mkdir -p $(BUILD_DIR)
mkdir -p $(ISO_DIR)

$(BOOT_BIN): $(BOOT_SRC)
@echo "Biên dịch bootloader..."
$(ASM) -f bin $< -o $@

$(KERNEL_ENTRY_OBJ): $(KERNEL_SRC)
@echo "Biên dịch kernel GUI..."
$(ASM) -f bin $< -o $@

$(KERNEL_BIN): $(KERNEL_ENTRY_OBJ)
@echo "Chuẩn bị kernel..."
cp $< $@

$(OS_IMAGE): $(BOOT_BIN) $(KERNEL_BIN)
@echo "Tạo OS image..."
cat $^ > $@
truncate -s 1440K $@

$(ISO_IMAGE): $(OS_IMAGE)
@echo "Tạo ISO image..."
mkdir -p $(ISO_DIR)/boot
cp $< $(ISO_DIR)/boot/
genisoimage -quiet -V "MiniOS" -input-charset iso8859-1 -o $@ -b boot/os-image.bin -hide boot.catalog $(ISO_DIR) || mkisofs -quiet -V "MiniOS" -input-charset iso8859-1 -o $@ -b boot/os-image.bin -hide boot.catalog $(ISO_DIR)
@echo "ISO đã tạo: $(ISO_IMAGE)"

run-iso: $(ISO_IMAGE)
@echo "Chạy ISO trong QEMU..."
qemu-system-i386 -cdrom $(ISO_IMAGE)

clean:
rm -rf $(BUILD_DIR) $(ISO_DIR)

.PHONY: all directories run-iso clean
