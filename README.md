# MiniOS v4.0.1 – Nhóm 15

MiniOS là một hệ điều hành giáo dục 16-bit viết hoàn toàn bằng NASM Assembly, chạy ở Real Mode với mục tiêu minh họa quy trình khởi động, quản lý màn hình văn bản và tổ chức kernel theo kiến trúc modular. Phiên bản v4.0.1 cung cấp giao diện menu đồ họa văn bản và nhiều ứng dụng tích hợp để luyện tập lập trình hệ điều hành mức thấp.

## 🔧 **HOTFIX v4.0.1 - Khắc phục lỗi keyboard**

**Thay đổi trong phiên bản này:**

- ✅ **Fix keyboard hanging**: Thay đổi `read_line` từ blocking sang polling mode
- ✅ **Thêm ESC key support**: Nhấn ESC để thoát khỏi input bị treo
- ✅ **Cải thiện tương thích QEMU**: Tốt hơn trên các máy khác nhau
- ✅ **Emergency exit**: Nếu bị treo, nhấn ESC thay vì phải restart QEMU

**Lỗi đã fix:**

- Editor không phản hồi sau khi nhập tên file và nhấn Enter
- Cursor nhấp nháy đen và treo hệ thống trong input
- Keyboard interrupt không nhận diện đúng trên một số máy

## Tính năng chính

- Bootloader 512 byte đọc kernel từ đĩa mềm (INT 13h) và nhảy vào vùng `0x1000`.
- Màn hình boot có logo, thanh tiến trình giả lập và thông tin nhóm phát triển.
- Kernel modular gồm các module `core`, `utils`, `apps` dễ mở rộng và bảo trì.
- Terminal tương tác với các lệnh: `help`, `clear`, `time`, `date`, `ver`, `exit`.
- Đồng hồ & lịch đọc RTC BIOS (INT 1Ah), hiển thị giờ–ngày–thứ theo thời gian thực.
- Trình soạn thảo file lưu tối đa 5 file (vùng RAM 1.680 byte) với thao tác tạo/xem/sửa.
- Trò chơi Tic Tac Toe dành cho 2 người chơi trên cùng bàn phím.
- Máy tính giải phương trình bậc hai, tính Delta và phân loại nghiệm.
- Màn hình thông tin hệ thống và lựa chọn reboot (INT 19h/triple fault).

## Kiến trúc & Luồng khởi động

1. **Bootloader** (`boot/boot.asm`) được BIOS nạp tại `0x7C00`, thiết lập segment, hiển thị thông báo và đọc 64 sector kernel vào `0x1000`.
2. **Kernel** (`kernel/kernel.asm`) khởi tạo chế độ văn bản 80×25, hiển thị boot screen rồi chuyển tới menu chính.
3. **Core Modules**
   - `core/boot.asm`: màn hình boot, logo, thanh tiến trình.
   - `core/menu.asm`: menu chính, điều hướng bằng phím mũi tên, gọi ứng dụng.
   - `core/data.asm`: toàn bộ chuỗi giao diện, biến trạng thái, bộ đệm.
4. **Utilities** (`kernel/utils`): thao tác màn hình (`screen.asm`), bàn phím (`keyboard.asm`), chuỗi (`string.asm`), thời gian (`time.asm`).
5. **Applications** (`kernel/apps`): terminal, clock, editor, game, calculator, about, reboot – mỗi ứng dụng là một module độc lập, quay lại `main_menu` khi kết thúc.

## Cấu trúc thư mục

```
MiniOS_demogr15/
├─ boot/               # Bootloader 16-bit
├─ kernel/             # Kernel modular và các ứng dụng
│  ├─ core/            # Boot screen, menu, dữ liệu tĩnh
│  ├─ utils/           # Thư viện hỗ trợ màn hình, chuỗi, thời gian, bàn phím
│  └─ apps/            # Terminal, đồng hồ, editor, game, calculator, about, reboot
├─ build/              # Thư mục đầu ra (boot.bin, kernel.bin, os-image.bin)
├─ iso/                # Chứa ISO bootable sau khi build
├─ scripts/            # Script build, setup môi trường, chạy QEMU
├─ Makefile            # Quy trình build chính (NASM → BIN → ISO)
└─ TEAM_ASSIGNMENTS.md # Phân công công việc của Nhóm 15
```

## Yêu cầu hệ thống

- **Hệ điều hành**: Linux, macOS (cài NASM & QEMU), hoặc Windows thông qua WSL/Git Bash.
- **Công cụ bắt buộc**: `nasm`, `make`, `qemu-system-i386`, `genisoimage` (hoặc `mkisofs`), `truncate`, `cat`, `cp`.
- **Tùy chọn**: `bash` để chạy các script tự động trong thư mục `scripts/`.

> Windows thuần (PowerShell) nên cài WSL + Ubuntu và chạy dự án trong môi trường WSL để tránh thiếu công cụ.

## Thiết lập môi trường

Trên hệ thống Debian/Ubuntu hoặc WSL, có thể dùng script:

```bash
./scripts/setup.sh
```

Script sẽ cài NASM, build-essential, QEMU, genisoimage… bằng `apt`. Nếu dùng hệ điều hành khác, hãy cài đặt thủ công các gói tương đương (Homebrew trên macOS, `pacman` trên Arch, v.v.).

## Build & chạy

### Build toàn bộ

```bash
make
```

- Sinh `build/boot.bin`, `build/kernel.bin`, `build/os-image.bin` và `iso/minios.iso`.
- Makefile mặc định sử dụng `kernel/kernel_gui.asm`; nếu đang phát triển trên `kernel/kernel.asm`, cập nhật biến `KERNEL_SRC` khi cần.

### Chạy trên QEMU

```bash
make run-iso
```

Hoặc sử dụng script tiện ích:

```bash
./scripts/test-qemu.sh
```

### Build nhanh bằng script

```bash
./scripts/build.sh
```

Script sẽ xóa thư mục `build`/`iso`, biên dịch lại và tạo ISO mới.

### Dùng trên máy ảo khác

1. Tạo máy ảo (VirtualBox/VMware).
2. Gắn file `iso/minios.iso` làm ổ CD/DVD.
3. Boot từ CD/DVD để vào MiniOS.

## Ứng dụng tích hợp

- **Terminal** (`kernel/apps/terminal.asm`): giao diện dòng lệnh với các lệnh thời gian, ngày tháng, phiên bản.
- **Clock & Calendar** (`kernel/apps/clock.asm`): cập nhật thời gian thực, thoát bằng `ESC`.
- **File Editor** (`kernel/apps/editor.asm`): hệ file trong RAM, tối đa 5 file × 336 byte, menu tạo/xem/sửa.
- **Tic Tac Toe** (`kernel/apps/game.asm`): chơi luân phiên, kiểm tra thắng/thua/hòa.
- **Calculator** (`kernel/apps/calculator.asm`): giải phương trình bậc hai, hiển thị Delta, phân loại nghiệm.
- **About & Reboot**: thông tin nhóm phát triển và lựa chọn khởi động lại.

## Quy tắc đóng góp

- Giữ mã nguồn NASM chuẩn 16-bit, tuân theo convention hiện có (comment block đầu file, chia module).
- Khi thêm module mới, cập nhật `kernel/kernel.asm`, `kernel/core/menu.asm` và `kernel/core/data.asm` tương ứng.
- Tôn trọng giới hạn bộ nhớ (Real Mode), tránh cấp phát vượt quá vùng `kernel` (~32 KB).
- Kiểm thử bằng `make run-iso` hoặc `scripts/test-qemu.sh` trước khi gửi pull request.
- Ghi chú thay đổi ở README/CHANGELOG (khi có) để toàn đội nắm được.

## Cập nhật phiên bản mới

Nếu đã clone repo và muốn cập nhật khi có version mới:

### Cách 1: Git Pull (Khuyên dùng)

```bash
cd MiniOS_demogr15
git pull origin main
./scripts/build.sh
```

### Cách 2: Xem thay đổi trước khi pull

```bash
git fetch origin
git log HEAD..origin/main --oneline  # Xem commits mới
git diff HEAD..origin/main           # Xem chi tiết thay đổi
git pull origin main                 # Pull về
```

### Cách 3: Nếu có thay đổi local

```bash
git stash              # Lưu thay đổi tạm
git pull origin main   # Pull version mới
git stash pop          # Lấy lại thay đổi (có thể có conflict)
```

### Cách 4: Clone lại từ đầu (nếu lỗi)

```bash
cd ..
rm -rf MiniOS_demogr15
git clone https://github.com/Poicitaco/MiniOS_demogr15.git
cd MiniOS_demogr15
./scripts/build.sh
```

### Kiểm tra version hiện tại

```bash
git log --oneline -1          # Xem commit gần nhất
cat kernel/core/data.asm | grep "v4.0"  # Xem version trong code
```

## Khắc phục sự cố

- **`nasm: command not found`**: cài NASM (`sudo apt install nasm` hoặc `brew install nasm`).
- **Không tạo được ISO**: đảm bảo `genisoimage` hoặc `mkisofs` đã cài (`sudo apt install genisoimage`).
- **QEMU không chạy**: kiểm tra quyền truy cập X11 (Linux) hoặc dùng tham số `-display sdl`/`-curses` nếu không có GUI.
- **Màn hình bị "đóng băng"**: trong QEMU nhấn `Ctrl+Alt+G` để nhả chuột, `Ctrl+Alt+Q` để thoát.
- **Git pull bị conflict**: xem [Cách 3](#cập-nhật-phiên-bản-mới) hoặc backup rồi clone lại.

## Nhóm phát triển

- **Nhóm 15 – Môn Hệ Điều Hành (HDH)**.
- **Nhóm trưởng**: Hoàng Tiến Đạt.
- **Thành viên**: Nguyễn Hữu Đăng Khoa, Nguyễn Đức Mạnh, Phạm Văn Tuấn Kiệt, Mầu Danh Chiến.
- Thông tin chi tiết về phân công nhiệm vụ: xem `TEAM_ASSIGNMENTS.md`.

MiniOS v4.0 là nền tảng thuận tiện để học và diễn giải hoạt động của một hệ điều hành nhỏ gọn. Chúc bạn học tập và khám phá vui vẻ!
