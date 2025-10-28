## Makefile cho Mini OS

ASM = nasm
BUILD_DIR = build
ISO_DIR = iso
BOOT_SRC = boot/boot.asm
KERNEL_SRC = kernel/kernel_gui.asm
BOOT_BIN = $(BUILD_DIR)/boot.bin
KERNEL_BIN = $(BUILD_DIR)/kernel.bin
OS_IMAGE = $(BUILD_DIR)/os-image.bin
ISO_IMAGE = $(ISO_DIR)/minios.iso

all: directories $(ISO_IMAGE)

directories:
	@mkdir -p $(BUILD_DIR)
	@mkdir -p $(ISO_DIR)

$(BOOT_BIN): $(BOOT_SRC)
	@echo "Biên dịch bootloader..."
	$(ASM) -f bin $< -o $@

$(KERNEL_BIN): $(KERNEL_SRC)
	@echo "Biên dịch kernel GUI..."
	$(ASM) -f bin $< -o $@

$(OS_IMAGE): $(BOOT_BIN) $(KERNEL_BIN)
	@echo "Tạo OS image..."
	cat $^ > $@
	@truncate -s 1440K $@

$(ISO_IMAGE): $(OS_IMAGE)
	@echo "Tạo ISO..."
	@mkdir -p $(ISO_DIR)/boot
	@cp $< $(ISO_DIR)/boot/
	@genisoimage -quiet -V "MiniOS" -o $@ -b boot/os-image.bin $(ISO_DIR) || mkisofs -quiet -V "MiniOS" -o $@ -b boot/os-image.bin $(ISO_DIR)
	@echo "Hoàn tất: $(ISO_IMAGE)"

run-iso: $(ISO_IMAGE)
	@qemu-system-i386 -cdrom $(ISO_IMAGE)

clean:
	@rm -rf $(BUILD_DIR) $(ISO_DIR)

.PHONY: all directories run-iso clean
