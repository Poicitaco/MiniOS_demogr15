# MiniOS v4.0 - Hệ Điều Hành 16-bit# MiniOS v4.0 - Hệ Điều Hành 16-bit# MiniOS v4.0 - Hệ Điều Hành 16-bit# MiniOS v4.0 - Hệ Điều Hành 16-bit# MiniOS v3.0 - Modular Operating System

<div align="center"><div align="center"><div align="center"><div align="center">[![Assembly](https://img.shields.io/badge/Assembly-x86-blue.svg)](https://nasm.us/)

![Version](https://img.shields.io/badge/version-4.0-blue.svg)![Version](https://img.shields.io/badge/version-4.0-blue.svg)![Version](https://img.shields.io/badge/version-4.0-blue.svg)[![Architecture](https://img.shields.io/badge/Architecture-Modular-green.svg)]()

![License](https://img.shields.io/badge/license-MIT-green.svg)

![Assembly](https://img.shields.io/badge/Assembly-x86-red.svg)![License](https://img.shields.io/badge/license-MIT-green.svg)

![Architecture](https://img.shields.io/badge/16--bit-orange.svg)

![Assembly](https://img.shields.io/badge/language-x86%20Assembly-red.svg)![License](https://img.shields.io/badge/license-MIT-green.svg)

**Hệ điều hành nhỏ gọn bằng x86 Assembly**

![Architecture](https://img.shields.io/badge/architecture-16--bit-orange.svg)

[Tính Năng](#-tính-năng) • [Cài Đặt](#-cài-đặt) • [Team](#-team) • [Tài Liệu](TEAM_ASSIGNMENTS.md)

![Assembly](https://img.shields.io/badge/language-x86%20Assembly-red.svg)![Version](https://img.shields.io/badge/version-4.0-blue.svg)[![License](https://img.shields.io/badge/License-Educational-orange.svg)]()

</div>

**Hệ điều hành nhỏ gọn được xây dựng hoàn toàn bằng x86 Assembly**

---

![Architecture](https://img.shields.io/badge/architecture-16--bit-orange.svg)

## 📖 Giới Thiệu

</div>

**MiniOS v4.0** - Hệ điều hành minimal bằng **x86 Assembly (NASM)** cho môn **Hệ Điều Hành**

![License](https://img.shields.io/badge/license-MIT-green.svg)

**Giảng viên**: TS. Lê Hoàng Anh - Khoa Công Nghệ Thông Tin

---

**Đặc điểm**:

- ✅ 16-bit Real Mode**Hệ điều hành nhỏ gọn được xây dựng hoàn toàn bằng x86 Assembly**

- ✅ Kiến trúc modular

- ✅ 7 ứng dụng tích hợp## 📖 Giới Thiệu

- ✅ Giao diện tiếng Việt

![Assembly](https://img.shields.io/badge/language-x86%20Assembly-red.svg)## 🎯 Overview

---

**MiniOS v4.0** là một hệ điều hành minimal được phát triển hoàn toàn bằng **x86 Assembly (NASM)** cho môn học **Hệ Điều Hành** dưới sự hướng dẫn của **TS. Lê Hoàng Anh** - Khoa Công Nghệ Thông Tin.

## 🎯 Tính Năng

[Tính Năng](#-tính-năng) • [Cài Đặt](#-cài-đặt--chạy) • [Hướng Dẫn](#-hướng-dẫn-sử-dụng) • [Team](#-team-members) • [Tài Liệu](#-tài-liệu-kỹ-thuật)

1. **Terminal** - CLI với 6 lệnh: help, clear, time, date, ver, exit

2. **Đồng Hồ** - Real-time clock từ BIOS### ✨ Đặc Điểm Nổi Bật

3. **File Editor** - Virtual FS, 5 files × 256 bytes

4. **Tic Tac Toe** - Game 2 người chơi![Architecture](https://img.shields.io/badge/architecture-16--bit-orange.svg)

5. **Calculator** - Giải PT bậc 2 (Newton-Raphson √)

6. **Thông Tin** - System info & team- ✅ 16-bit Real Mode bootloader

7. **Reboot** - Khởi động lại

- ✅ Kiến trúc modular dễ mở rộng</div>

---

- ✅ 7 ứng dụng tích hợp

## 🏗️ Kiến Trúc

- ✅ Giao diện tiếng ViệtMiniOS v3.0 là một hệ điều hành minimal được viết hoàn toàn bằng x86 Assembly, với **kiến trúc modular** giúp dễ dàng phát triển và mở rộng.

````

Bootloader (512B) → Kernel (16KB)- ✅ Text Mode 80x25

├─ Utils:    screen, keyboard, string, time

├─ Core:     boot, menu, data---

└─ Apps:     terminal, clock, editor, game, calculator, about, reboot

```---



**Memory**: 0x7C00 (boot) | 0x1000-0x4FFF (kernel) | 0x9000 (stack)**Hệ điều hành nhỏ gọn được xây dựng hoàn toàn bằng x86 Assembly**



---## 🎯 Tính Năng



## 📦 Cài Đặt## 📋 Mục Lục



### 1. Clone & Dependencies### 1. Terminal 🖥️

```bash

git clone https://github.com/Poicitaco/MiniOS_demogr15.gitCommand-line interface với 6 lệnh cơ bản:### ✨ Key Features

cd MiniOS_demogr15

- `help` - Hiển thị danh sách lệnh

# Ubuntu/Debian/WSL

sudo apt update && sudo apt install nasm qemu-system-x86- `clear` - Xóa màn hình- [Giới Thiệu](#-giới-thiệu)

````

- `time` - Hiển thị giờ hiện tại

### 2. Build & Run

```bash- `date` - Hiển thị ngày- [Tính Năng](#-tính-năng)[Tính Năng](#-tính-năng) • [Cài Đặt](#-cài-đặt--chạy) • [Hướng Dẫn](#-hướng-dẫn-sử-dụng) • [Team](#-team-members) • [Tài Liệu](#-tài-liệu-kỹ-thuật)

./scripts/build.sh # Build

./scripts/test-qemu.sh # Test trong QEMU- `ver` - Version hệ thống

# hoặc

make run- `exit` - Thoát về menu- [Kiến Trúc](#-kiến-trúc)

````

### 2. Đồng Hồ & Lịch ⏰- [Yêu Cầu Hệ Thống](#-yêu-cầu-hệ-thống)1. **💻 Terminal** - Interactive command-line interface

### 3. Tạo USB Bootable

```bash- Real-time clock từ BIOS

# ⚠️ Cảnh báo: Xóa dữ liệu USB

sudo dd if=build/os-image.bin of=/dev/sdX bs=512- Hiển thị ngày/tháng/năm- [Cài Đặt & Chạy](#-cài-đặt--chạy)

````

- Thứ trong tuần (tiếng Việt)

### 4. VirtualBox

- Tạo VM: Type Other, RAM 64MB- Cập nhật liên tục- [Hướng Dẫn Sử Dụng](#-hướng-dẫn-sử-dụng)</div>2. **⏰ Clock & Calendar** - Real-time display từ BIOS

- Storage → Add CD/DVD → `iso/minios.iso`

- Boot### 3. File Editor 📝- [Cấu Trúc Dự Án](#-cấu-trúc-dự-án)

---- Virtual file system trong RAM

## 📖 Sử Dụng- Tối đa 5 files- [Phân Công Công Việc](#-phân-công-công-việc)3. **📝 File Editor** - Simple text file editor

**Boot**: Nhấn phím → Menu chính- Mỗi file 256 bytes

**Menu**: ↑↓ di chuyển, Enter chọn

**Terminal**: `help` xem lệnh- Tìm kiếm file theo tên- [Team Members](#-team-members)

**Calculator**: Nhập a, b, c → Xem kết quả

### 4. Tic Tac Toe 🎮- [Screenshots](#-screenshots)---4. **🎮 Tic Tac Toe** - Classic 2-player game

---

- Game 2 người chơi

## 👥 Team

- Bảng 3x3- [License](#-license)

**Giảng viên**: TS. Lê Hoàng Anh

- Kiểm tra thắng/thua/hòa

**Nhóm 15**:

- 🏆 **Hoàng Tiến Đạt** (Leader) - Calculator & Architecture- Interface trực quan5. **ℹ️ About** - System information

- **Nguyễn Hữu Đăng Khoa** - File Editor & String

- **Nguyễn Đức Mạnh** - Clock & Time### 5. Calculator 🧮---

- **Phạm Văn Tuấn Kiệt** - Game, Keyboard & Menu

- **Mầu Danh Chiến** - Terminal, UI & Core**Giải Phương Trình Bậc 2**: ax² + bx + c = 0

📋 **Chi tiết phân công**: [TEAM_ASSIGNMENTS.md](TEAM_ASSIGNMENTS.md)- Tính Delta (Δ = b² - 4ac)## 📋 Mục Lục6. **🔄 Reboot** - System restart

---- Thuật toán Newton-Raphson tính √

## 📁 Cấu Trúc- Hiển thị nghiệm chính xác## 🚀 Giới Thiệu

`````- Giao diện Casio fx-580

MiniOS_demogr15/

├── boot/boot.asm         # Bootloader- [Giới Thiệu](#-giới-thiệu)## 🏗️ Modular Architecture

├── kernel/

│   ├── kernel.asm        # Entry point### 6. Thông Tin ℹ️

│   ├── utils/            # screen, keyboard, string, time

│   ├── core/             # boot, menu, data- Thông tin hệ thống**MiniOS v4.0** là một hệ điều hành nhỏ gọn được phát triển hoàn toàn bằng **x86 Assembly (NASM)** cho môn học **Hệ Điều Hành (HDH)** dưới sự hướng dẫn của **TS. Lê Hoàng Anh**. Dự án này nhằm mục đích hiểu sâu về kiến trúc máy tính, quản lý bộ nhớ, và cơ chế hoạt động cơ bản của một hệ điều hành.

│   └── apps/             # 7 applications

├── scripts/              # build.sh, test-qemu.sh- Team members

├── build/                # Output

├── iso/minios.iso        # Bootable ISO- Version info- [Tính Năng](#-tính-năng)

└── README.md

```### 7. Khởi Động Lại 🔄### Đặc Điểm Nổi Bật



---- Reboot hệ thống



## 📚 Tech Stack- BIOS interrupt 19h- [Kiến Trúc](#-kiến-trúc)```



**BIOS Interrupts**: INT 10h (Video), INT 16h (Keyboard), INT 1Ah (Time), INT 19h (Reboot)---- ✅ **16-bit Real Mode** - Hoạt động ở chế độ thực 16-bit



**Build**: NASM, Make, QEMU, genisoimage## 🏗️ Kiến Trúc- ✅ **Bootloader tùy chỉnh** - 512 bytes bootloader- [Yêu Cầu Hệ Thống](#-yêu-cầu-hệ-thống)kernel/



**LOC**: ~2,350 dòng Assembly````- ✅ **Kiến trúc modular** - Dễ dàng mở rộng và bảo trì



---┌─────────────────────────────────┐



## 🔧 Development│    BOOTLOADER (512 bytes)       │- ✅ **7 chức năng tích hợp** - Terminal, Clock, File Editor, Game, Calculator, About, Reboot- [Cài Đặt & Chạy](#-cài-đặt--chạy)├── kernel.asm # Main entry point



```bash│  - Load kernel vào memory       │

make clean    # Xóa build

make build    # Build only│  - Jump to kernel entry         │- ✅ **Giao diện tiếng Việt** - Thân thiện với người dùng Việt Nam

make run      # Build + run QEMU

make iso      # Tạo ISO└─────────────────────────────────┘

`````

              ↓- ✅ **Text Mode 80x25** - Giao diện console cổ điển- [Hướng Dẫn Sử Dụng](#-hướng-dẫn-sử-dụng)├── utils/ # Reusable utilities

**Debug**:

````bash┌─────────────────────────────────┐

qemu-system-i386 -drive format=raw,file=build/os-image.bin -monitor stdio

```│       KERNEL (16 KB)            │---- [Cấu Trúc Dự Án](#-cấu-trúc-dự-án)│ ├── screen.asm # Screen operations



---├─────────────────────────────────┤



## 📄 License│  📁 Utils                       │## 🎯 Tính Năng- [Phân Công Công Việc](#-phân-công-công-việc)│ ├── keyboard.asm # Keyboard input



MIT License © 2025 MiniOS Team - Nhóm 15│    ├─ screen.asm                │



---│    ├─ keyboard.asm              │### 1. **Terminal** 🖥️- [Team Members](#-team-members)│ ├── string.asm # String functions



<div align="center">│    ├─ string.asm                │



**⭐ Star nếu hữu ích! ⭐**│    └─ time.asm                  │- Command-line interface cơ bản



Made with ❤️ by **Nhóm 15** - HDH 2025├─────────────────────────────────┤



**Đạt • Khoa • Mạnh • Kiệt • Chiến**│  🔧 Core                        │- Hỗ trợ 6 lệnh: `help`, `clear`, `time`, `date`, `ver`, `exit`- [Screenshots](#-screenshots)│ └── time.asm # Time/date functions



Hướng dẫn: **TS. Lê Hoàng Anh**│    ├─ boot.asm                  │



🔗 [GitHub](https://github.com/Poicitaco/MiniOS_demogr15) • 📋 [Team Assignments](TEAM_ASSIGNMENTS.md)│    ├─ menu.asm                  │- Hiển thị thời gian thực và thông tin hệ thống



</div>│    └─ data.asm                  │


├─────────────────────────────────┤- [License](#-license)├── core/ # Core system

│  🎯 Apps                        │

│    ├─ terminal.asm              │### 2. **Đồng Hồ & Lịch** 🕐

│    ├─ clock.asm                 │

│    ├─ editor.asm                │- Hiển thị thời gian thực (Real-time clock)│ ├── boot.asm # Boot screen

│    ├─ game.asm                  │

│    ├─ calculator.asm            │- Ngày tháng năm từ BIOS RTC

│    ├─ about.asm                 │

│    └─ reboot.asm                │- Hiển thị thứ trong tuần (tiếng Việt)---│ ├── menu.asm # Main menu

└─────────────────────────────────┘

```- Cập nhật liên tục



### Memory Layout│ └── data.asm # All data/strings



```### 3. **File Editor** 📝

0x0000 - 0x03FF : Interrupt Vector Table

0x0400 - 0x04FF : BIOS Data Area- Quản lý tối đa 5 files trong memory## 🚀 Giới Thiệu└── apps/ # Applications

0x7C00 - 0x7DFF : Bootloader (512 bytes)

0x1000 - 0x4FFF : Kernel code (16 KB)- Tạo, xem, chỉnh sửa file

0x5000 - 0x8FFF : Kernel data & buffers

0x9000 - 0x9FFF : Stack (4 KB)- Virtual file system (1,680 bytes storage) ├── terminal.asm

````

- Tìm kiếm file theo tên

---

**MiniOS v4.0** là một hệ điều hành nhỏ gọn được phát triển hoàn toàn bằng **x86 Assembly (NASM)** cho môn học **Hệ Điều Hành (HDH)**. Dự án này nhằm mục đích hiểu sâu về kiến trúc máy tính, quản lý bộ nhớ, và cơ chế hoạt động cơ bản của một hệ điều hành. ├── clock.asm

## 💻 Yêu Cầu Hệ Thống

### 4. **Tic Tac Toe** 🎮

### Build Requirements

- **NASM** v2.14+- Game 2 người chơi ├── editor.asm

- **GNU Make** hoặc bash

- **QEMU** (testing)- Giao diện bảng 3x3

### Runtime Requirements- Kiểm tra thắng/thua/hòa### Đặc Điểm Nổi Bật ├── game.asm

- x86 CPU hoặc emulator

- 1 MB RAM tối thiểu- Hướng dẫn chi tiết

- VGA Text Mode support

  ├── about.asm

---

### 5. **Calculator - Giải Phương Trình Bậc 2** 🧮

## 📦 Cài Đặt & Chạy

- Nhập hệ số a, b, c- ✅ **16-bit Real Mode** - Hoạt động ở chế độ thực 16-bit └── reboot.asm

### 1. Clone Repository

- Tính Delta (Δ = b² - 4ac)

``````bash

git clone https://github.com/Poicitaco/MiniOS_demogr15.git- Tính căn bậc 2 (thuật toán Newton-Raphson)- ✅ **Bootloader tùy chỉnh** - 512 bytes bootloader```

cd MiniOS_demogr15

```- Hiển thị nghiệm chính xác:



### 2. Cài Đặt Dependencies  - Hai nghiệm phân biệt- ✅ **Kiến trúc modular** - Dễ dàng mở rộng và bảo trì



**Ubuntu/Debian:**  - Nghiệm kép

```bash

sudo apt update  - Nghiệm phức- ✅ **5 ứng dụng tích hợp** - Terminal, Clock, File Editor, Game, Calculator**Total**: 14 files, ~1,450 lines

sudo apt install nasm qemu-system-x86

```- Giao diện giống máy tính Casio fx-580



**Windows (WSL):**- ✅ **Giao diện tiếng Việt** - Thân thiện với người dùng Việt Nam

```bash

sudo apt update### 6. **Thông Tin Hệ Thống** ℹ️

sudo apt install nasm qemu-system-x86

```- Hiển thị thông tin về MiniOS- ✅ **Text Mode 80x25** - Giao diện console cổ điển## 🚀 Quick Start



### 3. Build- Thông tin nhóm phát triển



```bash- Version và credits---### Build

./scripts/build.sh

# hoặc### 7. **Khởi Động Lại** 🔄## 🎯 Tính Năng```bash

make

```- Reboot hệ thống



### 4. Test trong QEMU- Reset toàn bộ state./scripts/build.sh



```bash---### 1. **Terminal** 🖥️```

./scripts/test-qemu.sh

# hoặc## 🏗️ Kiến Trúc- Command-line interface cơ bản

make run

```### Sơ Đồ Hệ Thống- Hỗ trợ 6 lệnh: `help`, `clear`, `time`, `date`, `ver`, `exit`### Run in QEMU



### 5. Tạo Bootable USB`````- Hiển thị thời gian thực và thông tin hệ thống



```bash┌─────────────────────────────────────────────────┐

# ⚠️ CẢNH BÁO: Xóa toàn bộ dữ liệu trên USB

sudo dd if=build/os-image.bin of=/dev/sdX bs=512 status=progress│             BOOTLOADER (512 bytes)              │````bash

sync

```│  - Load kernel từ disk vào memory              │



### 6. VirtualBox/VMware│  - Jump to kernel entry point                   │### 2. **Đồng Hồ & Lịch** 🕐./scripts/test-qemu.sh



1. Tạo VM mới: Type: Other, RAM: 64MB└─────────────────────────────────────────────────┘

2. Settings → Storage → Add optical drive

3. Chọn `iso/minios.iso`                      ↓- Hiển thị thời gian thực (Real-time clock)# or

4. Boot từ CD/DVD

┌─────────────────────────────────────────────────┐

---

│              KERNEL (16 KB)                     │- Ngày tháng năm từ BIOS RTCmake run

## 📖 Hướng Dẫn Sử Dụng

├─────────────────────────────────────────────────┤

### Boot Screen

- Logo MiniOS với progress bar│  📁 Utils Module                                │- Hiển thị thứ trong tuần (tiếng Việt)```

- Nhấn phím bất kỳ để vào menu

│    ├─ screen.asm    - Quản lý màn hình         │

### Menu Chính

- Dùng **↑↓** để di chuyển│    ├─ keyboard.asm  - Xử lý bàn phím           │- Cập nhật liên tục

- **Enter** để chọn

- **ESC** để quay lại (trong apps)│    ├─ string.asm    - Thao tác chuỗi           │



### Terminal│    └─ time.asm      - Xử lý thời gian          │### Run in VirtualBox/VMware

``````

$ help # Xem lệnh├─────────────────────────────────────────────────┤

$ time # Hiện giờ

$ date # Hiện ngày│ 🔧 Core Module │### 3. **File Editor** 📝

$ ver # Version

$ exit # Thoát│ ├─ boot.asm - Boot screen │

```

│    ├─ menu.asm      - Main menu                │- Quản lý tối đa 5 files trong memory1. Create new VM

### Calculator

1. Nhập a (≠ 0)│    └─ data.asm      - Dữ liệu & biến           │

2. Nhập b

3. Nhập c├─────────────────────────────────────────────────┤- Tạo, xem, chỉnh sửa file2. Attach `iso/minios.iso` as CD/DVD

4. Xem kết quả với Delta và nghiệm

│  🎯 Applications                                │

---

│    ├─ terminal.asm  - Terminal                 │- Virtual file system (1,680 bytes storage)3. Boot from CD/DVD

## 📁 Cấu Trúc Dự Án

│    ├─ clock.asm     - Clock & Calendar         │

```

MiniOS_demogr15/│ ├─ editor.asm - File Editor │- Tìm kiếm file theo tên

├── boot/

│ └── boot.asm # Bootloader│ ├─ game.asm - Tic Tac Toe │

├── kernel/

│ ├── kernel.asm # Kernel entry│ ├─ calculator.asm - Quadratic Solver │## 📚 Documentation

│ ├── utils/ # Utilities

│ │ ├── screen.asm│ ├─ about.asm - System Info │

│ │ ├── keyboard.asm

│ │ ├── string.asm│ └─ reboot.asm - Reboot │### 4. **Tic Tac Toe** 🎮

│ │ └── time.asm

│ ├── core/ # Core system└─────────────────────────────────────────────────┘

│ │ ├── boot.asm

│ │ ├── menu.asm```- Game 2 người chơi- **[FEATURES.md](FEATURES.md)** - Detailed feature documentation

│ │ └── data.asm

│ └── apps/ # Applications

│ ├── terminal.asm

│ ├── clock.asm### Memory Layout- Giao diện bảng 3x3- **[MODULAR_ARCHITECTURE.md](MODULAR_ARCHITECTURE.md)** - Architecture guide

│ ├── editor.asm

│ ├── game.asm

│ ├── calculator.asm

│ ├── about.asm```- Kiểm tra thắng/thua/hòa- **[REBUILD_CHANGELOG.md](REBUILD_CHANGELOG.md)** - Version history

│ └── reboot.asm

├── scripts/0x0000 - 0x03FF : Interrupt Vector Table (IVT)

│ ├── build.sh # Build script

│ └── test-qemu.sh # QEMU test0x0400 - 0x04FF : BIOS Data Area (BDA)- Hướng dẫn chi tiết

├── build/ # Build output

├── iso/ # ISO image0x0500 - 0x7BFF : Free conventional memory

├── Makefile

├── README.md0x7C00 - 0x7DFF : Bootloader (512 bytes)## 🛠️ Development

└── TEAM_ASSIGNMENTS.md # Phân công chi tiết

```0x7E00 - 0x7FFF  : Stack space



---0x1000 - 0x4FFF  : Kernel code (16 KB)### 5. **Calculator - Giải Phương Trình Bậc 2** 🧮



## 👥 Team Members0x5000 - 0x8FFF  : Kernel data & buffers



### Giảng Viên Hướng Dẫn0x9000 - 0x9FFF  : Stack (4 KB)- Nhập hệ số a, b, c### Adding a New App

**TS. Lê Hoàng Anh** - Khoa Công Nghệ Thông Tin

```

### Nhóm 15 - HDH 2025

- Tính Delta (Δ = b² - 4ac)

<table>

  <tr>---

    <td align="center">

      <b>🏆 Hoàng Tiến Đạt</b><br>- Tính căn bậc 2 (thuật toán Newton-Raphson)1. Create `kernel/apps/myapp.asm`:

      <sub>Nhóm Trưởng</sub><br>

      <sub>Calculator & Architecture</sub>## 💻 Yêu Cầu Hệ Thống

    </td>

    <td align="center">- Hiển thị nghiệm chính xác:

      <b>Nguyễn Hữu Đăng Khoa</b><br>

      <sub>Thành Viên</sub><br>### Build Requirements

      <sub>File Editor & String Utils</sub>

    </td>- **NASM** (Netwide Assembler) v2.14+ - Hai nghiệm phân biệt```asm

    <td align="center">

      <b>Nguyễn Đức Mạnh</b><br>- **GNU Make** hoặc bash shell

      <sub>Thành Viên</sub><br>

      <sub>Clock & Time Utils</sub>- **QEMU** (cho testing) - qemu-system-i386 - Nghiệm képrun_myapp:

    </td>

  </tr>### Runtime Requirements - Nghiệm phức call clear_screen

  <tr>

    <td align="center">- x86 CPU (hoặc emulator)

      <b>Phạm Văn Tuấn Kiệt</b><br>

      <sub>Thành Viên</sub><br>- 1 MB RAM tối thiểu- Giao diện giống máy tính Casio fx-580 ; Your code here

      <sub>Game, Keyboard & Menu</sub>

    </td>- VGA Text Mode support

    <td align="center">

      <b>Mầu Danh Chiến</b><br>  jmp main_menu

      <sub>Thành Viên</sub><br>

      <sub>Terminal, UI & Core</sub>### Hệ Điều Hành Hỗ Trợ Build

    </td>

    <td align="center">- ✅ Linux (Ubuntu, Debian, Arch, etc.)---```

      <br>

      <b>5 Thành Viên</b><br>- ✅ Windows (WSL hoặc MinGW)

      <sub>~2,350 Lines of Code</sub>

    </td>- ✅ macOS (với NASM installed)

  </tr>

</table>---## 🏗️ Kiến Trúc2. Add to `kernel/kernel.asm`:

📋 **Chi tiết phân công**: Xem file [TEAM_ASSIGNMENTS.md](TEAM_ASSIGNMENTS.md)## 📦 Cài Đặt & Chạy

---### 1. Clone Repository### Sơ Đồ Hệ Thống```asm

## 📸 Screenshots`````bash%include "kernel/apps/myapp.asm"

### Boot Screengit clone https://github.com/Otispanhneil/MiniOS_demogr15.git

``````

===========================================================cd MiniOS_demogr15````

     __  __ _       _  ___  ____

    |  \/  (_)_ __ (_)/ _ \/ ___| `````

    | |\/| | | '_ \| | | | \___ \

    | |  | | | | | | | |_| |___) |┌─────────────────────────────────────────────────┐

    |_|  |_|_|_| |_|_|\___/|____/

                    ### 2. Cài Đặt Dependencies

                Phiên bản 4.0

         Phát triển bởi Nhóm 15│ BOOTLOADER (512 bytes) │3. Update menu in `kernel/core/menu.asm`



        [████████████████████]#### Ubuntu/Debian



     Nhấn phím bất kỳ để tiếp tục...```bash│ - Load kernel từ disk vào memory │

===========================================================

```sudo apt update



### Main Menusudo apt install nasm qemu-system-x86│ - Jump to kernel entry point │**See [MODULAR_ARCHITECTURE.md](MODULAR_ARCHITECTURE.md) for complete guide**

``````

           MINI OS v4.0 - NHÓM 15```



          === MENU CHÍNH ===└─────────────────────────────────────────────────┘



          > 1. Terminal#### Arch Linux

            2. Đồng Hồ & Lịch

            3. File Editor````bash ↓## 📊 Statistics

            4. Tic Tac Toe

            5. Calculatorsudo pacman -S nasm qemu

            6. Thông Tin

            7. Khởi Động Lại```┌─────────────────────────────────────────────────┐

`````



---

#### macOS (với Homebrew)│ KERNEL (16 KB) │| Metric | Value |

## 📚 Tài Liệu Kỹ Thuật

```bash

### BIOS Interrupts

brew install nasm qemu├─────────────────────────────────────────────────┤| --------------- | -------------- |

| Interrupt | Function | Description |

|-----------|----------|-------------|````

| INT 10h | Video Services | Screen & cursor |

| INT 16h | Keyboard | Input handling |│ 📁 Utils Module │| **Total Files** | 14 modules |

| INT 1Ah | Time | Real-time clock |

| INT 19h | Bootstrap | System reboot |#### Windows (WSL)



### Text Mode Colors```bash│ ├─ screen.asm - Quản lý màn hình │| **Total Lines** | ~1,450 |



| Code | Color | Usage |sudo apt update

|------|-------|-------|

| 0x07 | Light Gray | Default text |sudo apt install nasm qemu-system-x86│ ├─ keyboard.asm - Xử lý bàn phím │| **Bootloader** | 512 bytes |

| 0x09 | Light Blue | Borders |

| 0x0A | Light Green | Success |```

| 0x0C | Light Red | Errors |

| 0x0E | Yellow | Highlights |│ ├─ string.asm - Thao tác chuỗi │| **Kernel Size** | 16KB |

| 0x0F | White | Important |

### 3. Build Project

---

│ └─ time.asm - Xử lý thời gian │| **ISO Size** | 1.8MB |

## 🔧 Development

```bash

### Build Commands

# Sử dụng script build├─────────────────────────────────────────────────┤| **Features** | 6 applications |

```bash

make clean      # Xóa build files./scripts/build.sh

make build      # Build only

make run        # Build & run│ 🔧 Core Module │

make iso        # Create ISO

make all        # Clean + build + ISO# Hoặc sử dụng Makefile

`````

make│ ├─ boot.asm - Boot screen │## 🎓 Learning Path

### Debug với QEMU

``````

```bash

# Với monitor│ ├─ menu.asm - Main menu │

qemu-system-i386 -drive format=raw,file=build/os-image.bin -monitor stdio

### 4. Chạy trong QEMU

# Với GDB

qemu-system-i386 -s -S -drive format=raw,file=build/os-image.bin│ └─ data.asm - Dữ liệu & biến │1. **Beginner**: Start with `utils/screen.asm` and `apps/about.asm`

gdb

(gdb) target remote localhost:1234`````bash

(gdb) break *0x7c00

```# Chạy raw disk image├─────────────────────────────────────────────────┤2. **Intermediate**: Study `apps/terminal.asm` and `apps/editor.asm`



---make run



## 🐛 Known Limitations│ 🎯 Applications │3. **Advanced**: Explore `utils/time.asm` and `apps/game.asm`



- **File System**: RAM only (mất khi tắt), max 5 files# Hoặc sử dụng script

- **Calculator**: Integer only, sqrt làm tròn

- **Memory**: Real Mode 1MB limit./scripts/test-qemu.sh│ ├─ terminal.asm - Terminal │

- **Keyboard**: US layout only



---

# Chạy ISO image│ ├─ clock.asm - Clock & Calendar │## 🔧 Technical Details

## 📄 License

make run-iso

MIT License - Copyright (c) 2025 MiniOS Team - Nhóm 15

```│ ├─ editor.asm - File Editor │

---



## 🙏 Acknowledgments

### 5. Tạo Bootable USB (Thực Tế)│ ├─ game.asm - Tic Tac Toe │- **Language**: x86 Assembly (NASM)

- **TS. Lê Hoàng Anh** - Giảng viên hướng dẫn

- OSDev Wiki - Documentation

- NASM & QEMU teams

```bash│ ├─ calculator.asm - Quadratic Solver │- **Mode**: 16-bit Real Mode

---

# ⚠️ CẢNH BÁO: Lệnh này sẽ XÓA toàn bộ dữ liệu trên USB

## 📞 Contact

# Thay /dev/sdX bằng device của USB (kiểm tra bằng lsblk)│ ├─ about.asm - System Info │- **Display**: Text Mode 80x25

**Nhóm 15 - Hệ Điều Hành**



- 🔗 GitHub: [Poicitaco/MiniOS_demogr15](https://github.com/Poicitaco/MiniOS_demogr15)

- 🎓 Giảng viên: TS. Lê Hoàng Anhsudo dd if=build/os-image.bin of=/dev/sdX bs=512 count=33 status=progress│ └─ reboot.asm - Reboot │- **Memory**: 1MB addressable



---sync



<div align="center">```└─────────────────────────────────────────────────┘- **Boot**: BIOS Legacy



**⭐ Star nếu bạn thấy project hữu ích! ⭐**



Made with ❤️ by **Nhóm 15** - HDH 2025### 6. Chạy trên VirtualBox/VMware````- **Architecture**: Modular with %include



**Hoàng Tiến Đạt • Nguyễn Hữu Đăng Khoa • Nguyễn Đức Mạnh • Phạm Văn Tuấn Kiệt • Mầu Danh Chiến**



Hướng dẫn bởi **TS. Lê Hoàng Anh**1. Tạo máy ảo mới:



</div>   - Type: Other


   - Version: Other/Unknown### Memory Layout## 🎯 Why Modular?

   - RAM: 64 MB

   - No hard disk



2. Settings:```### Before (Monolithic)

   - System → Motherboard → Boot Order: CD/DVD

   - Storage → Add optical drive → Chọn `iso/minios.iso`0x0000 - 0x03FF  : Interrupt Vector Table (IVT)



3. Start máy ảo0x0400 - 0x04FF  : BIOS Data Area (BDA)- ❌ 1 file với 1,400+ dòng



---0x0500 - 0x7BFF  : Free conventional memory- ❌ Khó tìm bug



## 📖 Hướng Dẫn Sử Dụng0x7C00 - 0x7DFF  : Bootloader (512 bytes)- ❌ Khó thêm feature mới



### Boot Screen0x7E00 - 0x7FFF  : Stack space- ❌ Khó maintain



Khi khởi động, bạn sẽ thấy logo MiniOS với progress bar. Nhấn phím bất kỳ để vào menu chính.0x1000 - 0x4FFF  : Kernel code (16 KB)



### Menu Chính0x5000 - 0x8FFF  : Kernel data & buffers### After (Modular v3.0)



```0x9000 - 0x9FFF  : Stack (4 KB)

=== MENU CHÍNH ===

1. Terminal```- ✅ 14 files, mỗi file ~100 dòng

2. Đồng Hồ & Lịch

3. File Editor- ✅ Dễ debug từng module

4. Tic Tac Toe

5. Calculator (Phương Trình Bậc 2)---- ✅ Thêm feature = thêm 1 file

6. Thông Tin

7. Khởi Động Lại- ✅ Dễ maintain và mở rộng

``````

## 💻 Yêu Cầu Hệ Thống

Sử dụng phím **mũi tên lên/xuống** để di chuyển, **Enter** để chọn.

## 🚀 Roadmap

### Terminal Commands

### Build Requirements

| Lệnh | Chức năng |

|---------|-------------------------------------|- **NASM** (Netwide Assembler) v2.14+### v3.1

| `help` | Hiển thị danh sách lệnh |

| `clear` | Xóa màn hình |- **GNU Make** hoặc bash shell

| `time` | Hiển thị giờ hiện tại |

| `date` | Hiển thị ngày hiện tại |- **QEMU** (cho testing) - qemu-system-i386- [ ] Calculator app

| `ver` | Hiển thị version hệ thống |

| `exit` | Thoát về menu chính |- [ ] More terminal commands

### File Editor### Runtime Requirements- [ ] Multi-line file editor

1. **Tạo File**: Chọn option 1, nhập tên file- x86 CPU (hoặc emulator)

2. **Xem & Sửa**: Chọn option 2, nhập tên file cần sửa

3. Tối đa 5 files, mỗi file 256 bytes- 1 MB RAM tối thiểu### v4.0

### Tic Tac Toe- VGA Text Mode support

- Nhấn số **1-9** để đặt X hoặc O vào ô tương ứng- [ ] Simple filesystem (FAT12)

- Nhấn **ESC** để thoát game

- Người chơi X đi trước### Hệ Điều Hành Hỗ Trợ Build- [ ] Graphics mode support

### Calculator- ✅ Linux (Ubuntu, Debian, Arch, etc.)- [ ] Protected mode transition

1. Nhập hệ số **a** (≠ 0)- ✅ Windows (WSL hoặc MinGW)

2. Nhập hệ số **b**

3. Nhập hệ số **c**- ✅ macOS (với NASM installed)## 🤝 Contributing

4. Xem kết quả với Delta và nghiệm

---

---Đây là educational project. Feel free to:

## 📁 Cấu Trúc Dự Án

````

MiniOS_demogr15/## 📦 Cài Đặt & Chạy- Fork and modify

├── boot/

│   └── boot.asm              # Bootloader (512 bytes)- Add new features

│

├── kernel/### 1. Clone Repository- Report issues

│   ├── kernel.asm            # Kernel entry point

│   │- Improve documentation

│   ├── utils/                # Utility modules

│   │   ├── screen.asm        # Screen management```bash

│   │   ├── keyboard.asm      # Keyboard input

│   │   ├── string.asm        # String operationsgit clone https://github.com/Otispanhneil/MiniOS_demogr15.git## 📄 License

│   │   └── time.asm          # Time/Date functions

│   │cd MiniOS_demogr15

│   ├── core/                 # Core system modules

│   │   ├── boot.asm          # Boot screen```Educational project - Free to use and modify

│   │   ├── menu.asm          # Main menu

│   │   └── data.asm          # Data & variables

│   │

│   └── apps/                 # Application modules### 2. Cài Đặt Dependencies## 🙏 Credits

│       ├── terminal.asm      # Terminal app

│       ├── clock.asm         # Clock & Calendar

│       ├── editor.asm        # File Editor

│       ├── game.asm          # Tic Tac Toe#### Ubuntu/DebianBuilt with:

│       ├── calculator.asm    # Quadratic Solver

│       ├── about.asm         # System Info```bash

│       └── reboot.asm        # Reboot function

│sudo apt update- NASM (Netwide Assembler)

├── scripts/

│   ├── build.sh              # Build scriptsudo apt install nasm qemu-system-x86- QEMU (Testing)

│   ├── setup.sh              # Setup script

│   └── test-qemu.sh          # QEMU test script```- x86 Assembly

│

├── build/                    # Build output (generated)- BIOS Interrupts

│   ├── boot.bin              # Compiled bootloader

│   ├── kernel.bin            # Compiled kernel#### Arch Linux

│   └── os-image.bin          # Final OS image

│```bashInspired by: BareMetal OS, MikeOS

├── iso/                      # ISO output (generated)

│   └── minios.iso            # Bootable ISOsudo pacman -S nasm qemu

│

├── Makefile                  # Build automation```---

└── README.md                 # Documentation

````

---#### macOS (với Homebrew)**MiniOS v3.0** - Learn OS development the modular way! 🎓 - Hệ điều hành nhỏ gọn

## 👥 Phân Công Công Việc```bash

### Giảng Viên Hướng Dẫnbrew install nasm qemuMột hệ điều hành đơn giản boot từ ISO image và chạy trên máy ảo x86 (VMware, VirtualBox, QEMU).

**TS. Lê Hoàng Anh** - Khoa Công Nghệ Thông Tin

`````

---

## Tính năng

### Nguyên Tắc Phân Công

Các thành viên được phân công theo mức độ khó tăng dần:#### Windows (WSL)



**Mức 1 (Khó nhất) ⭐⭐⭐⭐⭐** → **Mức 5 (Dễ nhất) ⭐**````bash- ✅ Bootloader tự viết



---sudo apt update- ✅ Kernel GUI viết bằng Assembly thuần túy



### 🏆 Nhóm Trưởng: Hoàng Tiến Đạtsudo apt install nasm qemu-system-x86- ✅ Driver hiển thị VGA mode 13h (320x200, 256 màu)

**Mức độ: ⭐⭐⭐⭐⭐ (Khó nhất)**

```- ✅ Hỗ trợ nhập liệu từ bàn phím

#### Trách nhiệm chính:

1. **Kiến trúc tổng thể hệ thống**- ✅ Giao diện đồ họa (GUI) với menu bar

   - Thiết kế kiến trúc modular

   - Quản lý memory layout### 3. Build Project- ✅ Các ứng dụng: Calculator, Text Editor, Terminal, File Manager

   - Tích hợp các module

- ✅ File ISO bootable

2. **Calculator - Giải Phương Trình Bậc 2** (`calculator.asm`)

   - Thuật toán Newton-Raphson tính căn bậc 2```bash- ✅ Chạy trên VMware, VirtualBox, và QEMU

   - Integer arithmetic cho phương trình bậc 2

   - String to integer conversion# Sử dụng script build

   - Signed number display

   - Xử lý các trường hợp đặc biệt (Delta > 0, = 0, < 0)./scripts/build.sh## Các lệnh có sẵn (trong Terminal app)



3. **Core System** (`kernel.asm`)

   - Entry point và segment setup

   - Module inclusion order# Hoặc sử dụng Makefile- `help` - Hiển thị các lệnh có sẵn

   - System initialization

make- `clear` - Xóa màn hình

#### Files chịu trách nhiệm:

- `kernel/kernel.asm````- `about` - Thông tin về OS

- `kernel/apps/calculator.asm`

- `time` - Hiển thị thời gian hệ thống (placeholder)

#### Thách thức kỹ thuật:

- Implement căn bậc 2 không dùng FPU### 4. Chạy trong QEMU- `reboot` - Khởi động lại hệ thống

- Division và multiplication 16-bit

- Error handling cho input không hợp lệ



**Lines of Code: ~500 lines**```bash## Yêu cầu hệ thống



---# Chạy raw disk image



### 👨‍💻 Thành viên 1: Nguyễn Hữu Đăng Khoamake run### Để build (WSL/Linux)

**Mức độ: ⭐⭐⭐⭐ (Khó)**



#### Trách nhiệm chính:

1. **File Editor** (`editor.asm`)# Hoặc sử dụng script- NASM assembler (trình biên dịch Assembly)

   - Virtual file system (5 files × 336 bytes)

   - File management (create, view, edit)./scripts/test-qemu.sh- GCC compiler (dự phòng cho tương lai)

   - File search by name

   - Buffer management- GNU Make (công cụ build automation)



2. **String Utilities** (`string.asm`)# Chạy ISO image- genisoimage (tạo file ISO)

   - strcmp, strcpy functions

   - String manipulationmake run-iso- QEMU (tùy chọn, để test)



#### Files chịu trách nhiệm:````

- `kernel/apps/editor.asm`

- `kernel/utils/string.asm`### Để chạy



#### Thách thức kỹ thuật:### 5. Tạo Bootable USB (Thực Tế)

- Quản lý multiple files trong limited memory

- Pointer arithmetic cho file positions- VMware Workstation/Player

- File name lookup algorithm

````bash- VirtualBox

**Lines of Code: ~450 lines**

# ⚠️ CẢNH BÁO: Lệnh này sẽ XÓA toàn bộ dữ liệu trên USB- QEMU

---

# Thay /dev/sdX bằng device của USB (kiểm tra bằng lsblk)- Hoặc bất kỳ máy ảo x86 nào

### 👨‍💻 Thành viên 2: Nguyễn Đức Mạnh

**Mức độ: ⭐⭐⭐ (Trung bình)**



#### Trách nhiệm chính:sudo dd if=build/os-image.bin of=/dev/sdX bs=512 count=33 status=progress## Hướng dẫn nhanh

1. **Clock & Calendar** (`clock.asm`)

   - Real-time clock từ BIOS (INT 1Ah)sync

   - BCD to ASCII conversion

   - Day of week calculation```### 1. Cài đặt môi trường (WSL)

   - Continuous update loop



2. **Time Utilities** (`time.asm`)

   - Time formatting functions### 6. Chạy trên VirtualBox/VMware```bash

   - Date formatting functions

   - BIOS RTC interface# Di chuyển đến thư mục project



#### Files chịu trách nhiệm:1. Tạo máy ảo mới:cd /mnt/c/Users/itent/Desktop/Best/MiniOS

- `kernel/apps/clock.asm`

- `kernel/utils/time.asm`   - Type: Other



#### Thách thức kỹ thuật:   - Version: Other/Unknown# Chạy script setup để cài đặt dependencies

- BIOS interrupt handling

- BCD conversion   - RAM: 64 MBchmod +x scripts/*.sh

- Real-time display update

   - No hard disk./scripts/setup.sh

**Lines of Code: ~350 lines**

`````

---

2. Settings:

### 👨‍💻 Thành viên 3: Phạm Văn Tuấn Kiệt

**Mức độ: ⭐⭐ (Khá dễ)** - System → Motherboard → Boot Order: CD/DVD### 2. Build hệ điều hành

#### Trách nhiệm chính: - Storage → Add optical drive → Chọn `iso/minios.iso`

1. **Tic Tac Toe Game** (`game.asm`)

   - Game logic (win/draw detection)```bash

   - Board rendering

   - Player turn management3. Start máy ảo# Build tất cả

   - Input validation

make

2. **Keyboard Utilities** (`keyboard.asm`)

   - read_char function---

   - read_line function

   - Input buffer management# Hoặc dùng script build

3. **Main Menu** (`menu.asm`)## 📖 Hướng Dẫn Sử Dụng./scripts/build.sh

   - Menu navigation với arrow keys

   - Menu selection và routing```

   - Menu state management

### Boot Screen

#### Files chịu trách nhiệm:

- `kernel/apps/game.asm`### 3. Test trong QEMU

- `kernel/utils/keyboard.asm`

- `kernel/core/menu.asm`Khi khởi động, bạn sẽ thấy logo MiniOS với progress bar. Nhấn phím bất kỳ để vào menu chính.

#### Thách thức kỹ thuật:```bash

- Win condition checking (8 cases)

- Board state management### Menu Chính# Chạy ISO trong QEMU

- Menu navigation logic

make run-iso

**Lines of Code: ~500 lines**

````

---

=== MENU CHÍNH ===# Hoặc dùng script test

### 👨‍💻 Thành viên 4: Mầu Danh Chiến

**Mức độ: ⭐ (Dễ nhất)**1. Terminal./scripts/test-qemu.sh



#### Trách nhiệm chính:2. Đồng Hồ & Lịch```

1. **Terminal** (`terminal.asm`)

   - Command parsing đơn giản3. File Editor

   - 6 basic commands (help, clear, time, date, ver, exit)

   - Command execution4. Tic Tac Toe### 4. Chạy trong VirtualBox



2. **Screen Utilities** (`screen.asm`)5. Calculator (Phương Trình Bậc 2)

   - clear_screen, set_cursor

   - print_string, print_char6. Thông Tin1. Mở VirtualBox

   - print_colored (basic color output)

7. Khởi Động Lại2. Tạo máy ảo mới:

3. **Boot Screen** (`boot.asm`)

   - Logo display```- Tên: Mini OS

   - Progress bar đơn giản

   - Welcome message   - Loại: Other



4. **Data Management** (`data.asm`)Sử dụng phím **mũi tên lên/xuống** để di chuyển, **Enter** để chọn.   - Phiên bản: Other/Unknown

   - Khai báo strings và messages

   - Variables declaration   - RAM: 128 MB (tối thiểu)

   - Buffer allocation

### Terminal Commands   - Không cần hard disk

5. **System Functions**

   - **About screen** (`about.asm`) - Hiển thị thông tin3. Settings → Storage → Thêm ổ đĩa quang (optical drive)

   - **Reboot** (`reboot.asm`) - BIOS interrupt 19h

| Lệnh    | Chức năng                           |4. Chọn file `iso/minios.iso`

#### Files chịu trách nhiệm:

- `kernel/apps/terminal.asm`|---------|-------------------------------------|5. Settings → System → Boot Order → Đặt CD/DVD lên đầu

- `kernel/apps/about.asm`

- `kernel/apps/reboot.asm`| `help`  | Hiển thị danh sách lệnh            |6. Khởi động VM

- `kernel/utils/screen.asm`

- `kernel/core/boot.asm`| `clear` | Xóa màn hình                       |

- `kernel/core/data.asm`

| `time`  | Hiển thị giờ hiện tại              |### 5. Chạy trong VMware

#### Thách thức kỹ thuật:

- BIOS INT 10h video functions (cơ bản)| `date`  | Hiển thị ngày hiện tại             |

- String comparison đơn giản

- Data organization| `ver`   | Hiển thị version hệ thống          |1. Mở VMware



**Lines of Code: ~550 lines**| `exit`  | Thoát về menu chính                |2. Tạo máy ảo mới:



**Ghi chú**: Các task của Chiến được chọn lọc để phù hợp với khả năng, tập trung vào các chức năng cơ bản, UI đơn giản, và không yêu cầu thuật toán phức tạp.   - Custom configuration



---### File Editor   - Guest OS: Other → Other



### 📊 Tóm Tắt Phân Công   - RAM: 128 MB



| STT | Thành Viên | Mức Độ | Số Files | Lines of Code | Modules Chính |1. **Tạo File**: Chọn option 1, nhập tên file3. Thêm CD/DVD drive với file `iso/minios.iso`

|-----|-----------|---------|----------|---------------|---------------|

| 1 | **Hoàng Tiến Đạt** (Leader) | ⭐⭐⭐⭐⭐ | 2 | ~500 | Calculator, Kernel Core |2. **Xem & Sửa**: Chọn option 2, nhập tên file cần sửa4. Bật nguồn VM

| 2 | Nguyễn Hữu Đăng Khoa | ⭐⭐⭐⭐ | 2 | ~450 | File Editor, String Utils |

| 3 | Nguyễn Đức Mạnh | ⭐⭐⭐ | 2 | ~350 | Clock, Time Utils |3. Tối đa 5 files, mỗi file 256 bytes

| 4 | Phạm Văn Tuấn Kiệt | ⭐⭐ | 3 | ~500 | Game, Keyboard, Menu |

| 5 | Mầu Danh Chiến | ⭐ | 6 | ~550 | Terminal, UI, Boot, Data |## Cấu trúc project

| | **TOTAL** | | **15** | **~2,350** | |

### Tic Tac Toe

---

````

## 👨‍💻 Team Members

- Nhấn số **1-9** để đặt X hoặc O vào ô tương ứngMiniOS/

<table>

  <tr>- Nhấn **ESC** để thoát game├── boot/

    <td align="center" width="200px">

      <img src="https://via.placeholder.com/150/0000FF/FFFFFF?text=HT%C4%90" width="100px" style="border-radius: 50%"/><br>- Người chơi X đi trước│ ├── boot.asm # Bootloader (512 bytes đầu tiên)

      <b>🏆 Hoàng Tiến Đạt</b><br>

      <sub><i>Nhóm Trưởng</i></sub><br>│ └── stage2.asm # Extended bootloader (nếu cần)

      <sub>Calculator & Architecture</sub><br>

      <sub>⭐⭐⭐⭐⭐</sub>### Calculator├── kernel/

    </td>

    <td align="center" width="200px">│ ├── kernel_gui.asm # Kernel GUI hoàn chỉnh (Assembly)

      <img src="https://via.placeholder.com/150/00FF00/FFFFFF?text=NH%C4%90K" width="100px" style="border-radius: 50%"/><br>

      <b>Nguyễn Hữu Đăng Khoa</b><br>1. Nhập hệ số **a** (≠ 0)│ └── pixel_font.asm # Font bitmap cho GUI

      <sub><i>Thành Viên</i></sub><br>

      <sub>File Editor & String Utils</sub><br>2. Nhập hệ số **b**├── scripts/

      <sub>⭐⭐⭐⭐</sub>

    </td>3. Nhập hệ số **c**│ ├── setup.sh # Cài đặt dependencies

    <td align="center" width="200px">

      <img src="https://via.placeholder.com/150/FFFF00/000000?text=N%C4%90M" width="100px" style="border-radius: 50%"/><br>4. Xem kết quả với Delta và nghiệm│ ├── build.sh # Build OS

      <b>Nguyễn Đức Mạnh</b><br>

      <sub><i>Thành Viên</i></sub><br>│ └── test-qemu.sh # Test trong QEMU

      <sub>Clock & Time Utilities</sub><br>

      <sub>⭐⭐⭐</sub>---├── build/ # Output build (tự động tạo)

    </td>

  </tr>│ ├── boot.bin # Bootloader đã biên dịch

  <tr>

    <td align="center" width="200px">## 📁 Cấu Trúc Dự Án│ ├── kernel.bin # Kernel đã biên dịch

      <img src="https://via.placeholder.com/150/FF00FF/FFFFFF?text=PVTK" width="100px" style="border-radius: 50%"/><br>

      <b>Phạm Văn Tuấn Kiệt</b><br>│ └── os-image.bin # OS image hoàn chỉnh

      <sub><i>Thành Viên</i></sub><br>

      <sub>Game, Keyboard & Menu</sub><br>````├── iso/                       # ISO output (tự động tạo)

      <sub>⭐⭐</sub>

    </td>MiniOS_demogr15/│   └── minios.iso            # File ISO bootable

    <td align="center" width="200px">

      <img src="https://via.placeholder.com/150/FF6600/FFFFFF?text=M%C4%90C" width="100px" style="border-radius: 50%"/><br>├── boot/├── Makefile                   # Cấu hình build

      <b>Mầu Danh Chiến</b><br>

      <sub><i>Thành Viên</i></sub><br>│   └── boot.asm              # Bootloader (512 bytes)└── README.md                  # File này

      <sub>Terminal, UI & Core</sub><br>

      <sub>⭐</sub>│```

    </td>

    <td align="center" width="200px">├── kernel/

      <br><br>

      <b>Nhóm 15</b><br>│   ├── kernel.asm            # Kernel entry point## Các lệnh build

      <sub><i>HDH - 2025</i></sub><br>

      <sub>5 Thành Viên</sub><br>│   │

      <sub>~2,350 LOC</sub>

    </td>│   ├── utils/                # Utility modules```bash

  </tr>

</table>│   │   ├── screen.asm        # Screen managementmake              # Build OS và tạo ISO

---│ │ ├── keyboard.asm # Keyboard inputmake clean # Xóa các file build

## 📸 Screenshots│ │ ├── string.asm # String operationsmake run # Test với raw image trong QEMU

### Boot Screen│ │ └── time.asm # Time/Date functionsmake run-iso # Test với ISO trong QEMU

````

===========================================================│   │make help         # Hiển thị các target có sẵn

     ___      ___   ___   ___   _   ___    ___   ___

    |  _\/  \  |  _|   _| | | / _ \  / __| │   ├── core/                 # Core system modules```

    | | | | | | | | | | | | | | (_) | \__ \

    |_| |_| |_|_| |_| |_| |_|  \___/  |___/ │   │   ├── boot.asm          # Boot screen



                    Phiên bản 4.0                       │   │   ├── menu.asm          # Main menu## Xử lý sự cố

           Phát triển bởi Nhóm 15

     HDH - Hệ Điều Hành - Operating System            │   │   └── data.asm          # Data & variables



-----------------------------------------------------------│   │### Lỗi "Command not found"

           Đang tải các thành phần hệ thống...

│   └── apps/                 # Application modules

            [████████████████████]

│       ├── terminal.asm      # Terminal appCài đặt các công cụ còn thiếu:

===========================================================

              Nhấn phím bất kỳ để tiếp tục...│       ├── clock.asm         # Clock & Calendar

````

│ ├── editor.asm # File Editor```bash

### Main Menu

````│ ├── game.asm          # Tic Tac Toesudo apt update

                   MINI OS v4.0 - NHÓM 15

│       ├── calculator.asm    # Quadratic Solversudo apt install nasm gcc build-essential qemu-system-x86 genisoimage

              === MENU CHÍNH ===

│       ├── about.asm         # System Info```

              > 1. Terminal

                2. Đồng Hồ & Lịch│       └── reboot.asm        # Reboot function

                3. File Editor

                4. Tic Tac Toe│### Lỗi "Permission denied" khi chạy scripts

                5. Calculator (Phương Trình Bậc 2)

                6. Thông Tin├── scripts/

                7. Khởi Động Lại

```│   ├── build.sh              # Build scriptCấp quyền thực thi cho scripts:



### Terminal│   ├── setup.sh              # Setup script

````

Chào mừng đến với MiniOS Terminal!│ └── test-qemu.sh # QEMU test script```bash

Nhập 'help' để xem các lệnh khả dụng

│chmod +x scripts/\*.sh

$ help

Các lệnh: help, clear, time, date, ver, exit├── build/ # Build output (generated)```

$ ver│ ├── boot.bin # Compiled bootloader

MiniOS v4.0 - Hệ điều hành x86 Assembly modular

│ ├── kernel.bin # Compiled kernel### ISO không boot trong VirtualBox

$ time

10:42:35│ └── os-image.bin # Final OS image

$ date│1. Kiểm tra VM settings → System → Enable I/O APIC

28/10/2025

├── iso/ # ISO output (generated)2. Đảm bảo Boot Order có CD/DVD ở vị trí đầu

$ \_

```│ └── minios.iso            # Bootable ISO3. Xác nhận file ISO tồn tại và hợp lệ



### Calculator│

```

          === GIẢI PHƯƠNG TRÌNH BẬC 2 ===├── Makefile                  # Build automation### Màn hình đen trong QEMU



                  ax^2 + bx + c = 0└── README.md                 # This file

+====================================+```Đây là bình thường! OS boot và hiển thị giao diện GUI. Thử di chuyển chuột hoặc nhấn phím.

| a = 5 |

+------------------------------------+

| b = 8 |

+------------------------------------+---## Phát triển

| c = -3 |

+====================================+

+-------- KẾT QUẢ --------+## 👥 Phân Công Công Việc### Thêm lệnh mới (trong Terminal app)

Delta = 124

Hai nghiệm phân biệt:

x1 = 0### Nguyên Tắc Phân CôngChỉnh sửa `kernel/kernel_gui.asm`:

x2 = -1

```Các thành viên được phân công theo mức độ khó tăng dần:



### Tic Tac Toe1. Tìm phần xử lý command trong Terminal

```

              === TIC TAC TOE ===**Mức 1 (Khó nhất) ⭐⭐⭐⭐⭐** → **Mức 5 (Dễ nhất) ⭐**2. Thêm logic kiểm tra command mới

Hướng dẫn: Nhấn 1-9 để đánh dấu | ESC để thoát3. Viết hàm xử lý cho command đó

Xếp 3 ô liên tiếp (ngang, dọc, chéo) để thắng!

Người chơi X đi trước. Chúc may mắn!---4. Rebuild và test

          +---+---+---+

          | X | O | X |

          +---+---+---+### 🏆 Nhóm Trưởng: Hoàng Tiến Đạt### Sửa thông báo boot

          |   | X |   |

          +---+---+---+**Mức độ: ⭐⭐⭐⭐⭐ (Khó nhất)**

          | O |   |   |

          +---+---+---+Chỉnh sửa `boot/boot.asm` và thay đổi chuỗi `welcome_msg`.



          1 2 3  |  4 5 6  |  7 8 9#### Trách nhiệm chính:

Người chơi hiện tại: O1. **Kiến trúc tổng thể hệ thống**### Thay đổi màu sắc

Nhập vị trí (1-9) hoặc ESC: \_

````- Thiết kế kiến trúc modular



---   - Quản lý memory layoutChỉnh sửa `kernel/kernel_gui.asm` và sửa các giá trị màu:



## 📚 Tài Liệu Kỹ Thuật   - Tích hợp các module



### BIOS Interrupts Used- Màu RGB được định nghĩa ở phần palette



| Interrupt | Function | Description |2. **Calculator - Giải Phương Trình Bậc 2** (`calculator.asm`)- GUI colors được set trong phần initialization

|-----------|----------|-------------|

| INT 10h | Video Services | Screen output, cursor control |   - Thuật toán Newton-Raphson tính căn bậc 2

| INT 16h | Keyboard Services | Keyboard input |

| INT 1Ah | Time Services | Real-time clock |   - Integer arithmetic cho phương trình bậc 2## Chi tiết kỹ thuật

| INT 19h | System Bootstrap | Reboot system |

   - String to integer conversion

### Color Codes (Text Mode)

   - Signed number display- **Kiến trúc**: x86 (32-bit)

| Code | Color | Usage |

|------|-------|-------|   - Xử lý các trường hợp đặc biệt (Delta > 0, = 0, < 0)- **Phương thức boot**: BIOS (Legacy)

| 0x00 | Black | Background |

| 0x07 | Light Gray | Default text |- **Chế độ hiển thị**: VGA Mode 13h (320x200, 256 màu)

| 0x08 | Dark Gray | Disabled items |

| 0x09 | Light Blue | Borders |3. **Core System** (`kernel.asm`)- **Bàn phím**: PS/2 Interface qua BIOS interrupt

| 0x0A | Light Green | Success messages |

| 0x0B | Light Cyan | Headers |   - Entry point và segment setup- **File System**: Chưa có (kernel được bootloader load trực tiếp)

| 0x0C | Light Red | Error messages |

| 0x0E | Yellow | Highlights |   - Module inclusion order- **Memory Model**:

| 0x0F | White | Important text |

   - System initialization  - Bootloader: Real Mode (16-bit)

### Assembly Directives

  - Kernel: Real Mode với VGA graphics

```nasm

[BITS 16]          ; 16-bit code#### Files chịu trách nhiệm:- **Kích thước**:

[ORG 0x7C00]      ; Boot sector starts at 0x7C00

[ORG 0x1000]      ; Kernel starts at 0x1000- `kernel/kernel.asm`  - Bootloader: 512 bytes



times 510-($-$$) db 0    ; Padding- `kernel/apps/calculator.asm`  - Kernel: ~32 KB

dw 0xAA55                ; Boot signature

```  - ISO: ~1.5 MB (với padding)



---#### Thách thức kỹ thuật:



## 🔧 Development- Implement căn bậc 2 không dùng FPU## Cải tiến trong tương lai



### Build Commands- Division và multiplication 16-bit



```bash- Error handling cho input không hợp lệ- [ ] Protected mode (32-bit)

# Clean build

make clean- [ ] Hỗ trợ file system (FAT12/FAT16)



# Build only**Lines of Code: ~500 lines**- [ ] Quản lý bộ nhớ (memory management)

make build

- [ ] Multitasking (đa tác vụ)

# Build and run

make run---- [ ] Network stack (TCP/IP)



# Create ISO- [ ] Cải thiện GUI (độ phân giải cao hơn)

make iso

### 👨‍💻 Thành viên 1: Nguyễn Hữu Đăng Khoa- [ ] Hỗ trợ chuột PS/2 đầy đủ

# All (clean + build + iso)

make all**Mức độ: ⭐⭐⭐⭐ (Khó)**- [ ] Thêm nhiều ứng dụng

````

### Debug trong QEMU

#### Trách nhiệm chính:## Giấy phép

```bash

# Chạy với monitor1. **File Editor** (`editor.asm`)

qemu-system-i386 -drive format=raw,file=build/os-image.bin -monitor stdio

   - Virtual file system (5 files × 336 bytes)Đây là project học tập. Bạn tự do sử dụng, chỉnh sửa và phân phối.

# Chạy với GDB

qemu-system-i386 -s -S -drive format=raw,file=build/os-image.bin   - File management (create, view, edit)

gdb

(gdb) target remote localhost:1234   - File search by name## Tác giả

(gdb) break *0x7c00

(gdb) continue   - Buffer management

```

Được tạo ra như một project học tập về hệ điều hành.

---

2. **String Utilities** (`string.asm`)

## 🐛 Known Issues & Limitations

- strcmp, strcpy functions## Hỗ trợ

### Current Limitations

- String manipulation

1. **File System**:

   - Chỉ lưu trữ trong RAM (mất khi tắt)Nếu gặp vấn đề hoặc có câu hỏi, tham khảo:

   - Tối đa 5 files

   - Mỗi file 256 bytes#### Files chịu trách nhiệm:

2. **Calculator**:- `kernel/apps/editor.asm`- [OSDev Wiki](https://wiki.osdev.org/) - Tài liệu phát triển OS

   - Chỉ tính integer (không có số thập phân)

   - Căn bậc 2 làm tròn- `kernel/utils/string.asm`- [Writing a Simple Operating System](https://www.cs.bham.ac.uk/~exr/lectures/opsys/10_11/lectures/os-dev.pdf) - Hướng dẫn chi tiết

3. **Memory**:- [NASM Documentation](https://www.nasm.us/docs.php) - Tài liệu NASM

   - Real Mode: Giới hạn 1 MB

   - Không có memory protection#### Thách thức kỹ thuật:- [x86 Assembly Guide](https://www.cs.virginia.edu/~evans/cs216/guides/x86.html) - Hướng dẫn Assembly x86

4. **Keyboard**:- Quản lý multiple files trong limited memory

   - Chỉ hỗ trợ US keyboard layout- Pointer arithmetic cho file positions

   - Không hỗ trợ Unicode- File name lookup algorithm

### Future Improvements**Lines of Code: ~450 lines**

- [ ] Protected Mode (32-bit)---

- [ ] Disk I/O (đọc/ghi file thật)

- [ ] More applications### 👨‍💻 Thành viên 2: Nguyễn Đức Mạnh

- [ ] Network support**Mức độ: ⭐⭐⭐ (Trung bình)**

- [ ] Floating point arithmetic

- [ ] Better error handling#### Trách nhiệm chính:

1. **Clock & Calendar** (`clock.asm`)

--- - Real-time clock từ BIOS (INT 1Ah)

- BCD to ASCII conversion

## 📖 References - Day of week calculation

- Continuous update loop

### Learning Resources

2. **Time Utilities** (`time.asm`)

1. **OSDev Wiki**: https://wiki.osdev.org/ - Time formatting functions

1. **NASM Manual**: https://www.nasm.us/doc/ - Date formatting functions

1. **Ralf Brown's Interrupt List**: http://www.ctyme.com/rbrown.htm - BIOS RTC interface

1. **x86 Assembly Guide**: https://www.cs.virginia.edu/~evans/cs216/guides/x86.html

#### Files chịu trách nhiệm:

### Books- `kernel/apps/clock.asm`

- `kernel/utils/time.asm`

1. "Operating Systems: Three Easy Pieces" - Remzi H. Arpaci-Dusseau

2. "Modern Operating Systems" - Andrew S. Tanenbaum#### Thách thức kỹ thuật:

3. "Programming from the Ground Up" - Jonathan Bartlett- BIOS interrupt handling

- BCD conversion

---- Real-time display update

## 📄 License**Lines of Code: ~350 lines**

This project is licensed under the MIT License.---

```### 👨‍💻 Thành viên 3: Phạm Văn Tuấn Kiệt

MIT License**Mức độ: ⭐⭐ (Khá dễ)**



Copyright (c) 2025 MiniOS Team - Nhóm 15#### Trách nhiệm chính:

1. **Tic Tac Toe Game** (`game.asm`)

Permission is hereby granted, free of charge, to any person obtaining a copy   - Game logic (win/draw detection)

of this software and associated documentation files (the "Software"), to deal   - Board rendering

in the Software without restriction, including without limitation the rights   - Player turn management

to use, copy, modify, merge, publish, distribute, sublicense, and/or sell   - Input validation

copies of the Software, and to permit persons to whom the Software is

furnished to do so, subject to the following conditions:2. **Keyboard Utilities** (`keyboard.asm`)

   - read_char function

The above copyright notice and this permission notice shall be included in all   - read_line function

copies or substantial portions of the Software.   - Input buffer management



THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR#### Files chịu trách nhiệm:

IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,- `kernel/apps/game.asm`

FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.- `kernel/utils/keyboard.asm`

```

#### Thách thức kỹ thuật:

---- Win condition checking (8 cases)

- Board state management

## 🙏 Acknowledgments- Echo character handling

- **TS. Lê Hoàng Anh** - Giảng viên hướng dẫn môn Hệ Điều Hành**Lines of Code: ~400 lines**

- OSDev community vì tài liệu phong phú

- NASM team vì assembler tuyệt vời---

- QEMU team vì emulator mạnh mẽ

### 👨‍💻 Thành viên 4: Mầu Danh Chiến

---**Mức độ: ⭐ (Dễ nhất)**

## 📞 Contact#### Trách nhiệm chính:

1. **Terminal** (`terminal.asm`)

**Nhóm 15 - Hệ Điều Hành** - Command parsing

- 6 basic commands

- 🔗 GitHub: https://github.com/Otispanhneil/MiniOS_demogr15 - Command execution

- 📧 Email: [Team contact]

- 🎓 Giảng viên: TS. Lê Hoàng Anh2. **UI & Display**

  - **Screen utilities** (`screen.asm`)

--- - clear_screen, set_cursor

     - print_string, print_char, print_colored

<div align="center">

- **Boot screen** (`boot.asm`)

**⭐ Nếu bạn thấy project hữu ích, hãy cho chúng tôi một star! ⭐** - Logo display

     - Progress bar animation

Made with ❤️ by **Nhóm 15** - HDH Course 2025

- **Main menu** (`menu.asm`)

**Hoàng Tiến Đạt • Nguyễn Hữu Đăng Khoa • Nguyễn Đức Mạnh • Phạm Văn Tuấn Kiệt • Mầu Danh Chiến** - Menu navigation

     - Arrow key handling

Dưới sự hướng dẫn của **TS. Lê Hoàng Anh** - Menu selection

</div>3. **Data Management** (`data.asm`)

- All strings và messages
- Variables declaration
- Buffer allocation

4. **System Functions**
   - **About screen** (`about.asm`)
   - **Reboot** (`reboot.asm`)

#### Files chịu trách nhiệm:

- `kernel/apps/terminal.asm`
- `kernel/apps/about.asm`
- `kernel/apps/reboot.asm`
- `kernel/utils/screen.asm`
- `kernel/core/boot.asm`
- `kernel/core/menu.asm`
- `kernel/core/data.asm`

#### Thách thức kỹ thuật:

- BIOS INT 10h video functions
- String comparison
- Menu state management

**Lines of Code: ~600 lines**

---

### 📊 Tóm Tắt Phân Công

| STT | Thành Viên                  | Mức Độ     | Số Files | Lines of Code | Modules Chính             |
| --- | --------------------------- | ---------- | -------- | ------------- | ------------------------- |
| 1   | **Hoàng Tiến Đạt** (Leader) | ⭐⭐⭐⭐⭐ | 2        | ~500          | Calculator, Kernel Core   |
| 2   | Nguyễn Hữu Đăng Khoa        | ⭐⭐⭐⭐   | 2        | ~450          | File Editor, String Utils |
| 3   | Nguyễn Đức Mạnh             | ⭐⭐⭐     | 2        | ~350          | Clock, Time Utils         |
| 4   | Phạm Văn Tuấn Kiệt          | ⭐⭐       | 2        | ~400          | Game, Keyboard Utils      |
| 5   | Mầu Danh Chiến              | ⭐         | 7        | ~600          | Terminal, UI, Boot, Menu  |
|     | **TOTAL**                   |            | **15**   | **~2,300**    |                           |

---

## 👨‍💻 Team Members

<table>
  <tr>
    <td align="center" width="200px">
      <img src="https://via.placeholder.com/150/0000FF/FFFFFF?text=HT%C4%90" width="100px" style="border-radius: 50%"/><br>
      <b>🏆 Hoàng Tiến Đạt</b><br>
      <sub><i>Nhóm Trưởng</i></sub><br>
      <sub>Calculator & Architecture</sub><br>
      <sub>⭐⭐⭐⭐⭐</sub>
    </td>
    <td align="center" width="200px">
      <img src="https://via.placeholder.com/150/00FF00/FFFFFF?text=NH%C4%90K" width="100px" style="border-radius: 50%"/><br>
      <b>Nguyễn Hữu Đăng Khoa</b><br>
      <sub><i>Thành Viên</i></sub><br>
      <sub>File Editor & String Utils</sub><br>
      <sub>⭐⭐⭐⭐</sub>
    </td>
    <td align="center" width="200px">
      <img src="https://via.placeholder.com/150/FFFF00/000000?text=N%C4%90M" width="100px" style="border-radius: 50%"/><br>
      <b>Nguyễn Đức Mạnh</b><br>
      <sub><i>Thành Viên</i></sub><br>
      <sub>Clock & Time Utilities</sub><br>
      <sub>⭐⭐⭐</sub>
    </td>
  </tr>
  <tr>
    <td align="center" width="200px">
      <img src="https://via.placeholder.com/150/FF00FF/FFFFFF?text=PVTK" width="100px" style="border-radius: 50%"/><br>
      <b>Phạm Văn Tuấn Kiệt</b><br>
      <sub><i>Thành Viên</i></sub><br>
      <sub>Tic Tac Toe & Keyboard</sub><br>
      <sub>⭐⭐</sub>
    </td>
    <td align="center" width="200px">
      <img src="https://via.placeholder.com/150/FF6600/FFFFFF?text=M%C4%90C" width="100px" style="border-radius: 50%"/><br>
      <b>Mầu Danh Chiến</b><br>
      <sub><i>Thành Viên</i></sub><br>
      <sub>Terminal, UI & Core</sub><br>
      <sub>⭐</sub>
    </td>
    <td align="center" width="200px">
      <br><br>
      <b>Nhóm 15</b><br>
      <sub><i>HDH - 2025</i></sub><br>
      <sub>5 Thành Viên</sub><br>
      <sub>~2,300 LOC</sub>
    </td>
  </tr>
</table>

---

## 📸 Screenshots

### Boot Screen

````

===========================================================
**\_ \_** **\_ \_** \_ **\_ \_** **_
| _\/ \ | _| _| | | / \_ \ / **|
| | | | | | | | | | | | | | (\_) | \__ \
|_| |_| |_|_| |_| |_| |_| \_**/ |\_**/

                    Phiên bản 4.0
           Phát triển bởi Nhóm 15
     HDH - Hệ Điều Hành - Operating System

---

           Đang tải các thành phần hệ thống...

            [████████████████████]

===========================================================
Nhấn phím bất kỳ để tiếp tục...

```

### Main Menu
```

                   MINI OS v4.0 - NHÓM 15

              === MENU CHÍNH ===

              > 1. Terminal
                2. Đồng Hồ & Lịch
                3. File Editor
                4. Tic Tac Toe
                5. Calculator (Phương Trình Bậc 2)
                6. Thông Tin
                7. Khởi Động Lại

```

### Terminal
```

Chào mừng đến với MiniOS Terminal!
Nhập 'help' để xem các lệnh khả dụng

$ help
Các lệnh: help, clear, time, date, ver, exit

$ ver
MiniOS v4.0 - Hệ điều hành x86 Assembly modular

$ time
10:42:35

$ date
28/10/2025

$ \_

```

### Calculator
```

          === GIẢI PHƯƠNG TRÌNH BẬC 2 ===

                  ax^2 + bx + c = 0

+====================================+
| a = 5 |
+------------------------------------+
| b = 8 |
+------------------------------------+
| c = -3 |
+====================================+

+-------- KẾT QUẢ --------+
Delta = 124

Hai nghiệm phân biệt:
x1 = 0
x2 = -1

```

### Tic Tac Toe
```

              === TIC TAC TOE ===

Hướng dẫn: Nhấn 1-9 để đánh dấu | ESC để thoát
Xếp 3 ô liên tiếp (ngang, dọc, chéo) để thắng!
Người chơi X đi trước. Chúc may mắn!

          +---+---+---+
          | X | O | X |
          +---+---+---+
          |   | X |   |
          +---+---+---+
          | O |   |   |
          +---+---+---+

          1 2 3  |  4 5 6  |  7 8 9

Người chơi hiện tại: O
Nhập vị trí (1-9) hoặc ESC: \_

````

---

## 📚 Tài Liệu Kỹ Thuật

### BIOS Interrupts Used

| Interrupt | Function          | Description                   |
| --------- | ----------------- | ----------------------------- |
| INT 10h   | Video Services    | Screen output, cursor control |
| INT 16h   | Keyboard Services | Keyboard input                |
| INT 1Ah   | Time Services     | Real-time clock               |
| INT 19h   | System Bootstrap  | Reboot system                 |

### Color Codes (Text Mode)

| Code | Color       | Usage            |
| ---- | ----------- | ---------------- |
| 0x00 | Black       | Background       |
| 0x07 | Light Gray  | Default text     |
| 0x08 | Dark Gray   | Disabled items   |
| 0x09 | Light Blue  | Borders          |
| 0x0A | Light Green | Success messages |
| 0x0B | Light Cyan  | Headers          |
| 0x0C | Light Red   | Error messages   |
| 0x0E | Yellow      | Highlights       |
| 0x0F | White       | Important text   |

### Assembly Directives

```nasm
[BITS 16]          ; 16-bit code
[ORG 0x7C00]      ; Boot sector starts at 0x7C00
[ORG 0x1000]      ; Kernel starts at 0x1000

times 510-($-$$) db 0    ; Padding
dw 0xAA55                ; Boot signature
```

---

## 🔧 Development

### Build Commands

```bash
# Clean build
make clean

# Build only
make build

# Build and run
make run

# Create ISO
make iso

# All (clean + build + iso)
make all
```

### Debug trong QEMU

```bash
# Chạy với monitor
qemu-system-i386 -drive format=raw,file=build/os-image.bin -monitor stdio

# Chạy với GDB
qemu-system-i386 -s -S -drive format=raw,file=build/os-image.bin
gdb
(gdb) target remote localhost:1234
(gdb) break *0x7c00
(gdb) continue
```

---

## 🐛 Known Issues & Limitations

### Current Limitations

1. **File System**:

   - Chỉ lưu trữ trong RAM (mất khi tắt)
   - Tối đa 5 files
   - Mỗi file 256 bytes

2. **Calculator**:

   - Chỉ tính integer (không có số thập phân)
   - Căn bậc 2 làm tròn

3. **Memory**:

   - Real Mode: Giới hạn 1 MB
   - Không có memory protection

4. **Keyboard**:
   - Chỉ hỗ trợ US keyboard layout
   - Không hỗ trợ Unicode

### Future Improvements

- [ ] Protected Mode (32-bit)
- [ ] Disk I/O (đọc/ghi file thật)
- [ ] More applications
- [ ] Network support
- [ ] Floating point arithmetic
- [ ] Better error handling

---

## 📖 References

### Learning Resources

1. **OSDev Wiki**: https://wiki.osdev.org/
2. **NASM Manual**: https://www.nasm.us/doc/
3. **Ralf Brown's Interrupt List**: http://www.ctyme.com/rbrown.htm
4. **x86 Assembly Guide**: https://www.cs.virginia.edu/~evans/cs216/guides/x86.html

### Books

1. "Operating Systems: Three Easy Pieces" - Remzi H. Arpaci-Dusseau
2. "Modern Operating Systems" - Andrew S. Tanenbaum
3. "Programming from the Ground Up" - Jonathan Bartlett

---

## 📄 License

This project is licensed under the MIT License.

```
MIT License

Copyright (c) 2025 MiniOS Team - Nhóm 15

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
```

---

## 🙏 Acknowledgments

- Giảng viên môn Hệ Điều Hành đã hướng dẫn
- OSDev community vì tài liệu phong phú
- NASM team vì assembler tuyệt vời
- QEMU team vì emulator mạnh mẽ

---

## 📞 Contact

**Nhóm 15 - Hệ Điều Hành**

- 🔗 GitHub: https://github.com/Otispanhneil/MiniOS_demogr15
- 📧 Email: [Team contact]
- 📺 Demo Video: [Link if available]

---

<div align="center">

**⭐ Nếu bạn thấy project hữu ích, hãy cho chúng tôi một star! ⭐**

Made with ❤️ by **Nhóm 15** - HDH Course 2025

**Hoàng Tiến Đạt • Nguyễn Hữu Đăng Khoa • Nguyễn Đức Mạnh • Phạm Văn Tuấn Kiệt • Mầu Danh Chiến**

</div>
