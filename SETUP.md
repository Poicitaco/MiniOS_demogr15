# 🚀 Hướng Dẫn Cài Đặt MiniOS v4.0

> **Dành cho người mới bắt đầu** - Hướng dẫn từng bước chi tiết

---

## 📋 Mục Lục

1. [Kiểm tra hệ thống](#1-kiểm-tra-hệ-thống)
2. [Cài đặt môi trường](#2-cài-đặt-môi-trường)
3. [Clone repository](#3-clone-repository)
4. [Build và chạy](#4-build-và-chạy)
5. [Khắc phục lỗi thường gặp](#5-khắc-phục-lỗi-thường-gặp)

---

## 1. Kiểm tra hệ thống

### Hệ điều hành được hỗ trợ:

- ✅ Ubuntu/Debian Linux
- ✅ Windows (qua WSL - Windows Subsystem for Linux)
- ✅ macOS (với Homebrew)
- ✅ Arch Linux
- ⚠️ Windows thuần (PowerShell) - **KHÔNG khuyến khích**

### Kiểm tra bạn đang dùng OS gì:

**Trên Linux:**

```bash
uname -a
```

**Trên Windows:**

- Mở PowerShell và gõ: `wsl --help`
- Nếu thấy help text → Đã có WSL ✅
- Nếu lỗi "command not found" → Cần cài WSL ⚠️

---

## 2. Cài đặt môi trường

### 🔹 Option A: Ubuntu/Debian/WSL (KHUYÊN DÙNG)

#### Bước 1: Cập nhật hệ thống

```bash
sudo apt update
sudo apt upgrade -y
```

#### Bước 2: Cài đặt Git (nếu chưa có)

```bash
sudo apt install git -y
```

Kiểm tra:

```bash
git --version
# Kết quả: git version 2.x.x
```

#### Bước 3: Cài đặt NASM (Assembler)

```bash
sudo apt install nasm -y
```

Kiểm tra:

```bash
nasm -v
# Kết quả: NASM version 2.x.x
```

#### Bước 4: Cài đặt QEMU (Emulator)

```bash
sudo apt install qemu-system-x86 -y
```

Kiểm tra:

```bash
qemu-system-i386 --version
# Kết quả: QEMU emulator version x.x.x
```

#### Bước 5: Cài đặt build tools

```bash
sudo apt install build-essential genisoimage -y
```

#### ✅ Hoặc dùng script tự động:

```bash
# Sau khi clone repo (bước 3), chạy:
./scripts/setup.sh
```

---

### 🔹 Option B: Windows (Cài WSL trước)

#### Bước 1: Bật WSL trên Windows

**Cách 1: Qua Settings (Windows 11)**

1. Settings → Apps → Optional Features
2. Tìm "Windows Subsystem for Linux"
3. Bật và restart

**Cách 2: Qua PowerShell (Admin)**

```powershell
wsl --install
```

Restart máy sau khi cài.

#### Bước 2: Cài Ubuntu trên WSL

```powershell
wsl --install -d Ubuntu
```

Đợi cài xong, nó sẽ yêu cầu tạo username/password.

#### Bước 3: Vào Ubuntu WSL

Mở "Ubuntu" từ Start Menu hoặc gõ `wsl` trong PowerShell.

#### Bước 4: Làm theo **Option A** ở trên

---

### 🔹 Option C: macOS (Homebrew)

#### Bước 1: Cài Homebrew (nếu chưa có)

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

#### Bước 2: Cài Git

```bash
brew install git
```

#### Bước 3: Cài NASM

```bash
brew install nasm
```

#### Bước 4: Cài QEMU

```bash
brew install qemu
```

#### Bước 5: Cài coreutils

```bash
brew install coreutils
```

---

### 🔹 Option D: Arch Linux

```bash
sudo pacman -Syu
sudo pacman -S git nasm qemu make cdrtools
```

---

## 3. Clone repository

### Bước 1: Chọn thư mục làm việc

```bash
cd ~
# Hoặc
cd /mnt/c/Users/TenBan/Desktop  # WSL: Desktop của Windows
```

### Bước 2: Clone repo

```bash
git clone https://github.com/Poicitaco/MiniOS_demogr15.git
```

### Bước 3: Vào thư mục project

```bash
cd MiniOS_demogr15
```

### Bước 4: Kiểm tra files

```bash
ls -la
```

Bạn sẽ thấy:

```
boot/
kernel/
scripts/
build/
iso/
Makefile
README.md
TEAM_ASSIGNMENTS.md
SETUP.md (file này)
```

---

## 4. Build và chạy

### 🔹 Cách 1: Dùng script (ĐƠN GIẢN NHẤT)

#### Bước 1: Build

```bash
./scripts/build.sh
```

**Nếu lỗi "Permission denied":**

```bash
chmod +x scripts/*.sh
./scripts/build.sh
```

**Kết quả khi thành công:**

```
=====================================
  Build thành công!
=====================================

Các file output:
  • build/boot.bin
  • build/kernel.bin
  • build/os-image.bin
  • iso/minios.iso
```

#### Bước 2: Chạy trong QEMU

```bash
./scripts/test-qemu.sh
```

Một cửa sổ QEMU sẽ mở ra với MiniOS! 🎉

---

### 🔹 Cách 2: Dùng Makefile

```bash
# Build
make

# Build và chạy
make run

# Chỉ build ISO
make iso

# Chạy ISO trong QEMU
make run-iso

# Xóa build cũ
make clean
```

---

### 🔹 Cách 3: Build thủ công (học tập)

#### Bước 1: Tạo thư mục build

```bash
mkdir -p build iso/boot
```

#### Bước 2: Compile bootloader

```bash
nasm -f bin boot/boot.asm -o build/boot.bin
```

#### Bước 3: Compile kernel

```bash
nasm -f bin kernel/kernel_gui.asm -o build/kernel.bin
```

#### Bước 4: Tạo OS image

```bash
cat build/boot.bin build/kernel.bin > build/os-image.bin
truncate -s 1440K build/os-image.bin
```

#### Bước 5: Tạo ISO

```bash
cp build/os-image.bin iso/boot/
genisoimage -quiet -V "MiniOS" -o iso/minios.iso -b boot/os-image.bin iso/
```

#### Bước 6: Chạy

```bash
qemu-system-i386 -drive format=raw,file=build/os-image.bin
```

---

## 5. Khắc phục lỗi thường gặp

### ❌ Lỗi: `nasm: command not found`

**Nguyên nhân:** Chưa cài NASM

**Giải pháp:**

```bash
sudo apt install nasm -y
```

---

### ❌ Lỗi: `qemu-system-i386: command not found`

**Nguyên nhân:** Chưa cài QEMU

**Giải pháp:**

```bash
sudo apt install qemu-system-x86 -y
```

---

### ❌ Lỗi: `Permission denied` khi chạy script

**Nguyên nhân:** Script không có quyền execute

**Giải pháp:**

```bash
chmod +x scripts/*.sh
```

---

### ❌ Lỗi: `genisoimage: command not found`

**Nguyên nhân:** Chưa cài genisoimage

**Giải pháp:**

```bash
# Ubuntu/Debian
sudo apt install genisoimage -y

# macOS
brew install cdrtools

# Arch
sudo pacman -S cdrtools
```

---

### ❌ Lỗi: `truncate: command not found`

**Nguyên nhân:** Command line tools chưa đủ

**Giải pháp:**

```bash
# Ubuntu/Debian
sudo apt install coreutils -y

# macOS
brew install coreutils
```

---

### ❌ Lỗi: `make: command not found`

**Nguyên nhân:** Chưa cài Make

**Giải pháp:**

```bash
# Ubuntu/Debian
sudo apt install make -y

# macOS (đã có sẵn hoặc)
xcode-select --install
```

---

### ❌ QEMU chạy nhưng màn hình đen

**Nguyên nhân:** Build chưa đúng hoặc boot sector lỗi

**Giải pháp:**

```bash
# Rebuild từ đầu
make clean
./scripts/build.sh

# Kiểm tra boot.bin có đúng 512 bytes không
ls -lh build/boot.bin
# Phải thấy: 512 bytes
```

---

### ❌ Lỗi: `fatal: unable to access 'https://github.com/...'`

**Nguyên nhân:** Lỗi mạng hoặc Git config

**Giải pháp:**

```bash
# Thử lại
git clone https://github.com/Poicitaco/MiniOS_demogr15.git

# Hoặc dùng SSH (nếu đã setup SSH key)
git clone git@github.com:Poicitaco/MiniOS_demogr15.git
```

---

### ❌ WSL lỗi: `cannot execute binary file`

**Nguyên nhân:** Đang chạy Windows binary trong Linux

**Giải pháp:**
Đảm bảo bạn đang trong WSL:

```bash
# Kiểm tra
uname -a
# Phải thấy: Linux ... Microsoft ...

# Nếu không, mở Ubuntu app hoặc gõ:
wsl
```

---

### ❌ macOS lỗi: `xcrun: error: invalid active developer path`

**Nguyên nhân:** Chưa cài Xcode Command Line Tools

**Giải pháp:**

```bash
xcode-select --install
```

---

## 6. Kiểm tra cài đặt thành công

Chạy lệnh sau để test:

```bash
cd ~/MiniOS_demogr15
./scripts/build.sh && ./scripts/test-qemu.sh
```

**Kết quả mong đợi:**

1. ✅ Build thành công (không có lỗi)
2. ✅ QEMU mở ra
3. ✅ Thấy logo MiniOS
4. ✅ Nhấn phím → Vào menu
5. ✅ Có thể chọn Terminal, Clock, Game...

---

## 7. Sử dụng cơ bản

### Menu chính

- **↑↓**: Di chuyển
- **Enter**: Chọn
- **ESC**: Quay lại (trong apps)

### Terminal

```
$ help      # Xem lệnh
$ time      # Xem giờ
$ date      # Xem ngày
$ ver       # Version
$ clear     # Xóa màn hình
$ exit      # Thoát
```

### Calculator

1. Nhập `a` (hệ số bậc 2)
2. Nhập `b` (hệ số bậc 1)
3. Nhập `c` (hằng số)
4. Xem kết quả

### Thoát QEMU

- **Ctrl + Alt + G**: Nhả chuột
- **Ctrl + Alt + Q**: Thoát QEMU

---

## 8. Cập nhật version mới

Khi có update:

```bash
cd MiniOS_demogr15
git pull origin main
./scripts/build.sh
```

---

## 9. Gỡ cài đặt

```bash
# Xóa project
cd ~
rm -rf MiniOS_demogr15

# Gỡ QEMU (nếu không cần)
sudo apt remove qemu-system-x86 -y

# Gỡ NASM (nếu không cần)
sudo apt remove nasm -y
```

---

## 10. Nhận trợ giúp

### Nếu gặp lỗi:

1. **Đọc phần [Khắc phục lỗi](#5-khắc-phục-lỗi-thường-gặp)**
2. **Xem log chi tiết:**
   ```bash
   ./scripts/build.sh 2>&1 | tee build.log
   ```
3. **Kiểm tra version:**
   ```bash
   nasm -v
   qemu-system-i386 --version
   make --version
   ```

### Liên hệ:

- 📧 GitHub Issues: https://github.com/Poicitaco/MiniOS_demogr15/issues
- 📋 README: Xem file `README.md`
- 👥 Team: Xem file `TEAM_ASSIGNMENTS.md`

---

## 📚 Tài liệu bổ sung

- **README.md**: Tổng quan dự án
- **TEAM_ASSIGNMENTS.md**: Phân công chi tiết
- **kernel/**: Source code kernel
- **boot/**: Source code bootloader

---

<div align="center">

**🎓 Chúc bạn học tập vui vẻ!**

Made with ❤️ by **Nhóm 15** - HDH 2025

**Đạt • Khoa • Mạnh • Kiệt • Chiến**

Hướng dẫn: **TS. Lê Hoàng Anh**

</div>
