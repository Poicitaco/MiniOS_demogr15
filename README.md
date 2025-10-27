# Mini OS - Hệ điều hành nhỏ gọn

Một hệ điều hành đơn giản boot từ ISO image và chạy trên máy ảo x86 (VMware, VirtualBox, QEMU).

## Tính năng

- ✅ Bootloader tự viết
- ✅ Kernel GUI viết bằng Assembly thuần túy
- ✅ Driver hiển thị VGA mode 13h (320x200, 256 màu)
- ✅ Hỗ trợ nhập liệu từ bàn phím
- ✅ Giao diện đồ họa (GUI) với menu bar
- ✅ Các ứng dụng: Calculator, Text Editor, Terminal, File Manager
- ✅ File ISO bootable
- ✅ Chạy trên VMware, VirtualBox, và QEMU

## Các lệnh có sẵn (trong Terminal app)

- `help` - Hiển thị các lệnh có sẵn
- `clear` - Xóa màn hình
- `about` - Thông tin về OS
- `time` - Hiển thị thời gian hệ thống (placeholder)
- `reboot` - Khởi động lại hệ thống

## Yêu cầu hệ thống

### Để build (WSL/Linux)

- NASM assembler (trình biên dịch Assembly)
- GCC compiler (dự phòng cho tương lai)
- GNU Make (công cụ build automation)
- genisoimage (tạo file ISO)
- QEMU (tùy chọn, để test)

### Để chạy

- VMware Workstation/Player
- VirtualBox
- QEMU
- Hoặc bất kỳ máy ảo x86 nào

## Hướng dẫn nhanh

### 1. Cài đặt môi trường (WSL)

```bash
# Di chuyển đến thư mục project
cd /mnt/c/Users/itent/Desktop/Best/MiniOS

# Chạy script setup để cài đặt dependencies
chmod +x scripts/*.sh
./scripts/setup.sh
```

### 2. Build hệ điều hành

```bash
# Build tất cả
make

# Hoặc dùng script build
./scripts/build.sh
```

### 3. Test trong QEMU

```bash
# Chạy ISO trong QEMU
make run-iso

# Hoặc dùng script test
./scripts/test-qemu.sh
```

### 4. Chạy trong VirtualBox

1. Mở VirtualBox
2. Tạo máy ảo mới:
   - Tên: Mini OS
   - Loại: Other
   - Phiên bản: Other/Unknown
   - RAM: 128 MB (tối thiểu)
   - Không cần hard disk
3. Settings → Storage → Thêm ổ đĩa quang (optical drive)
4. Chọn file `iso/minios.iso`
5. Settings → System → Boot Order → Đặt CD/DVD lên đầu
6. Khởi động VM

### 5. Chạy trong VMware

1. Mở VMware
2. Tạo máy ảo mới:
   - Custom configuration
   - Guest OS: Other → Other
   - RAM: 128 MB
3. Thêm CD/DVD drive với file `iso/minios.iso`
4. Bật nguồn VM

## Cấu trúc project

```
MiniOS/
├── boot/
│   ├── boot.asm              # Bootloader (512 bytes đầu tiên)
│   └── stage2.asm            # Extended bootloader (nếu cần)
├── kernel/
│   ├── kernel_gui.asm        # Kernel GUI hoàn chỉnh (Assembly)
│   └── pixel_font.asm        # Font bitmap cho GUI
├── scripts/
│   ├── setup.sh              # Cài đặt dependencies
│   ├── build.sh              # Build OS
│   └── test-qemu.sh          # Test trong QEMU
├── build/                     # Output build (tự động tạo)
│   ├── boot.bin              # Bootloader đã biên dịch
│   ├── kernel.bin            # Kernel đã biên dịch
│   └── os-image.bin          # OS image hoàn chỉnh
├── iso/                       # ISO output (tự động tạo)
│   └── minios.iso            # File ISO bootable
├── Makefile                   # Cấu hình build
└── README.md                  # File này
```

## Các lệnh build

```bash
make              # Build OS và tạo ISO
make clean        # Xóa các file build
make run          # Test với raw image trong QEMU
make run-iso      # Test với ISO trong QEMU
make help         # Hiển thị các target có sẵn
```

## Xử lý sự cố

### Lỗi "Command not found"

Cài đặt các công cụ còn thiếu:

```bash
sudo apt update
sudo apt install nasm gcc build-essential qemu-system-x86 genisoimage
```

### Lỗi "Permission denied" khi chạy scripts

Cấp quyền thực thi cho scripts:

```bash
chmod +x scripts/*.sh
```

### ISO không boot trong VirtualBox

1. Kiểm tra VM settings → System → Enable I/O APIC
2. Đảm bảo Boot Order có CD/DVD ở vị trí đầu
3. Xác nhận file ISO tồn tại và hợp lệ

### Màn hình đen trong QEMU

Đây là bình thường! OS boot và hiển thị giao diện GUI. Thử di chuyển chuột hoặc nhấn phím.

## Phát triển

### Thêm lệnh mới (trong Terminal app)

Chỉnh sửa `kernel/kernel_gui.asm`:

1. Tìm phần xử lý command trong Terminal
2. Thêm logic kiểm tra command mới
3. Viết hàm xử lý cho command đó
4. Rebuild và test

### Sửa thông báo boot

Chỉnh sửa `boot/boot.asm` và thay đổi chuỗi `welcome_msg`.

### Thay đổi màu sắc

Chỉnh sửa `kernel/kernel_gui.asm` và sửa các giá trị màu:

- Màu RGB được định nghĩa ở phần palette
- GUI colors được set trong phần initialization

## Chi tiết kỹ thuật

- **Kiến trúc**: x86 (32-bit)
- **Phương thức boot**: BIOS (Legacy)
- **Chế độ hiển thị**: VGA Mode 13h (320x200, 256 màu)
- **Bàn phím**: PS/2 Interface qua BIOS interrupt
- **File System**: Chưa có (kernel được bootloader load trực tiếp)
- **Memory Model**:
  - Bootloader: Real Mode (16-bit)
  - Kernel: Real Mode với VGA graphics
- **Kích thước**:
  - Bootloader: 512 bytes
  - Kernel: ~32 KB
  - ISO: ~1.5 MB (với padding)

## Cải tiến trong tương lai

- [ ] Protected mode (32-bit)
- [ ] Hỗ trợ file system (FAT12/FAT16)
- [ ] Quản lý bộ nhớ (memory management)
- [ ] Multitasking (đa tác vụ)
- [ ] Network stack (TCP/IP)
- [ ] Cải thiện GUI (độ phân giải cao hơn)
- [ ] Hỗ trợ chuột PS/2 đầy đủ
- [ ] Thêm nhiều ứng dụng

## Giấy phép

Đây là project học tập. Bạn tự do sử dụng, chỉnh sửa và phân phối.

## Tác giả

Được tạo ra như một project học tập về hệ điều hành.

## Hỗ trợ

Nếu gặp vấn đề hoặc có câu hỏi, tham khảo:

- [OSDev Wiki](https://wiki.osdev.org/) - Tài liệu phát triển OS
- [Writing a Simple Operating System](https://www.cs.bham.ac.uk/~exr/lectures/opsys/10_11/lectures/os-dev.pdf) - Hướng dẫn chi tiết
- [NASM Documentation](https://www.nasm.us/docs.php) - Tài liệu NASM
- [x86 Assembly Guide](https://www.cs.virginia.edu/~evans/cs216/guides/x86.html) - Hướng dẫn Assembly x86
