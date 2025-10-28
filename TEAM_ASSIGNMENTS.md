# 👥 Phân Công Công Việc - Nhóm 15

## Giảng Viên Hướng Dẫn
**TS. Lê Hoàng Anh** - Khoa Công Nghệ Thông Tin

---

## Nguyên Tắc Phân Công

Các thành viên được phân công theo mức độ khó từ cao đến thấp:

**⭐⭐⭐⭐⭐** (Khó nhất) → **⭐** (Dễ nhất)

---

## 🏆 Nhóm Trưởng: Hoàng Tiến Đạt

### Mức độ: ⭐⭐⭐⭐⭐ (Khó nhất)

### Trách nhiệm

#### 1. Kiến trúc tổng thể
- Thiết kế kiến trúc modular
- Quản lý memory layout
- Tích hợp các module
- System initialization

#### 2. Calculator - Giải Phương Trình Bậc 2
**File**: `kernel/apps/calculator.asm` (~500 lines)

**Chức năng**:
- Thuật toán Newton-Raphson tính căn bậc 2
- Integer arithmetic cho ax² + bx + c = 0
- String to integer conversion
- Signed number display
- Tính Delta (Δ = b² - 4ac)
- Xử lý các trường hợp:
  - Delta > 0: Hai nghiệm phân biệt
  - Delta = 0: Nghiệm kép
  - Delta < 0: Nghiệm phức
  - a = 0: Lỗi (không phải bậc 2)

#### 3. Kernel Core
**File**: `kernel/kernel.asm` (~60 lines)

**Chức năng**:
- Entry point và segment setup
- Module inclusion order
- Jump to boot screen

### Thách thức kỹ thuật
- ❌ Không có FPU trong 16-bit Real Mode
- ✅ Implement căn bậc 2 bằng vòng lặp iterative
- ✅ Division và multiplication 16-bit
- ✅ Error handling cho input không hợp lệ
- ✅ Hiển thị số âm với dấu

### Files chịu trách nhiệm
- `kernel/kernel.asm`
- `kernel/apps/calculator.asm`

### Lines of Code: ~500

---

## 👨‍💻 Thành viên 1: Nguyễn Hữu Đăng Khoa

### Mức độ: ⭐⭐⭐⭐ (Khó)

### Trách nhiệm

#### 1. File Editor
**File**: `kernel/apps/editor.asm` (~450 lines)

**Chức năng**:
- Virtual file system trong RAM
- Quản lý 5 files × 336 bytes = 1,680 bytes
- File management:
  - Tạo file mới
  - Xem danh sách files
  - Tìm file theo tên
  - Edit nội dung file
- Buffer management
- Workflow: Create → View list → Select → Edit

#### 2. String Utilities
**File**: `kernel/utils/string.asm` (~46 lines)

**Chức năng**:
- `strcmp` - So sánh 2 chuỗi
- `strcpy` - Copy chuỗi
- String length calculation
- String manipulation

### Thách thức kỹ thuật
- ✅ Quản lý multiple files trong limited memory
- ✅ Pointer arithmetic cho file positions
- ✅ File name lookup algorithm (linear search)
- ✅ Memory layout cho file storage

### Files chịu trách nhiệm
- `kernel/apps/editor.asm`
- `kernel/utils/string.asm`

### Lines of Code: ~450

---

## 👨‍💻 Thành viên 2: Nguyễn Đức Mạnh

### Mức độ: ⭐⭐⭐ (Trung bình)

### Trách nhiệm

#### 1. Clock & Calendar
**File**: `kernel/apps/clock.asm` (~70 lines)

**Chức năng**:
- Real-time clock từ BIOS (INT 1Ah)
- BCD to ASCII conversion
- Day of week calculation
- Continuous update loop
- Hiển thị:
  - Giờ:phút:giây
  - Ngày/tháng/năm
  - Thứ (tiếng Việt)

#### 2. Time Utilities
**File**: `kernel/utils/time.asm` (~128 lines)

**Chức năng**:
- Time formatting functions
- Date formatting functions
- BIOS RTC interface (INT 1Ah)
- BCD conversion helpers

### Thách thức kỹ thuật
- ✅ BIOS interrupt handling
- ✅ BCD to decimal conversion
- ✅ Real-time display update
- ✅ Day of week algorithm

### Files chịu trách nhiệm
- `kernel/apps/clock.asm`
- `kernel/utils/time.asm`

### Lines of Code: ~350

---

## 👨‍💻 Thành viên 3: Phạm Văn Tuấn Kiệt

### Mức độ: ⭐⭐ (Khá dễ)

### Trách nhiệm

#### 1. Tic Tac Toe Game
**File**: `kernel/apps/game.asm` (~357 lines)

**Chức năng**:
- Game logic
  - Win detection (8 cases: 3 rows, 3 cols, 2 diagonals)
  - Draw detection
  - Player turn management
- Board rendering
  - 3×3 grid với borders
  - X và O symbols
- Input validation
  - Chỉ nhận 1-9
  - Kiểm tra ô đã đánh chưa

#### 2. Keyboard Utilities
**File**: `kernel/utils/keyboard.asm` (~70 lines)

**Chức năng**:
- `read_char` - Đọc 1 ký tự
- `read_line` - Đọc 1 dòng
- Input buffer management
- Echo character handling

#### 3. Main Menu
**File**: `kernel/core/menu.asm` (~158 lines)

**Chức năng**:
- Menu navigation với arrow keys (↑↓)
- Menu selection và routing
- Menu state management
- Highlight selected item
- Route to 7 apps

### Thách thức kỹ thuật
- ✅ Win condition checking (8 cases)
- ✅ Board state management
- ✅ Menu navigation logic
- ✅ Arrow key detection

### Files chịu trách nhiệm
- `kernel/apps/game.asm`
- `kernel/utils/keyboard.asm`
- `kernel/core/menu.asm`

### Lines of Code: ~500

---

## 👨‍💻 Thành viên 4: Mầu Danh Chiến

### Mức độ: ⭐ (Dễ nhất)

### Trách nhiệm

#### 1. Terminal
**File**: `kernel/apps/terminal.asm` (~143 lines)

**Chức năng**:
- Command parsing đơn giản
- 6 basic commands:
  - `help` - Hiển thị danh sách lệnh
  - `clear` - Xóa màn hình
  - `time` - Hiện giờ
  - `date` - Hiện ngày
  - `ver` - Version
  - `exit` - Thoát
- Command execution (switch-case style)

#### 2. Screen Utilities
**File**: `kernel/utils/screen.asm` (~60 lines)

**Chức năng**:
- `clear_screen` - Xóa màn hình
- `set_cursor` - Đặt vị trí cursor
- `print_string` - In chuỗi
- `print_char` - In ký tự
- `print_colored` - In với màu

#### 3. Boot Screen
**File**: `kernel/core/boot.asm` (~154 lines)

**Chức năng**:
- Logo display (ASCII art)
- Progress bar đơn giản
- Welcome message
- "Nhấn phím bất kỳ..."

#### 4. Data Management
**File**: `kernel/core/data.asm` (~159 lines)

**Chức năng**:
- Khai báo tất cả strings
- Menu strings (tiếng Việt)
- Error messages
- Welcome messages
- Variables declaration
- Buffer allocation

#### 5. About Screen
**File**: `kernel/apps/about.asm` (~75 lines)

**Chức năng**:
- Hiển thị thông tin hệ thống
- Team members
- Version info
- Đơn giản chỉ print strings

#### 6. Reboot Function
**File**: `kernel/apps/reboot.asm` (~27 lines)

**Chức năng**:
- BIOS interrupt 19h
- System reboot
- Rất đơn giản (3 instructions)

### Thách thức kỹ thuật
- ✅ BIOS INT 10h video functions (cơ bản)
- ✅ String comparison đơn giản
- ✅ Data organization
- ✅ ASCII art formatting

### Ghi chú
Các task của Chiến được chọn lọc để phù hợp với khả năng:
- ✅ Tập trung vào UI và hiển thị
- ✅ Không yêu cầu thuật toán phức tạp
- ✅ Logic đơn giản (if-else, switch-case)
- ✅ Chủ yếu là BIOS calls và string handling

### Files chịu trách nhiệm
- `kernel/apps/terminal.asm`
- `kernel/apps/about.asm`
- `kernel/apps/reboot.asm`
- `kernel/utils/screen.asm`
- `kernel/core/boot.asm`
- `kernel/core/data.asm`

### Lines of Code: ~550

---

## 📊 Tổng Kết

| STT | Thành Viên | Mức Độ | Files | LOC | Modules |
|-----|-----------|---------|-------|-----|---------|
| 1 | **Hoàng Tiến Đạt** | ⭐⭐⭐⭐⭐ | 2 | ~500 | Calculator, Kernel |
| 2 | Nguyễn Hữu Đăng Khoa | ⭐⭐⭐⭐ | 2 | ~450 | Editor, String |
| 3 | Nguyễn Đức Mạnh | ⭐⭐⭐ | 2 | ~350 | Clock, Time |
| 4 | Phạm Văn Tuấn Kiệt | ⭐⭐ | 3 | ~500 | Game, Keyboard, Menu |
| 5 | Mầu Danh Chiến | ⭐ | 6 | ~550 | Terminal, UI, Boot, Data |
| | **TỔNG** | | **15** | **~2,350** | |

---

## 🔄 Quy Trình Làm Việc

### 1. Setup (Tất cả)
```bash
git clone https://github.com/Poicitaco/MiniOS_demogr15.git
cd MiniOS_demogr15
./scripts/setup.sh
```

### 2. Development
- Mỗi thành viên làm việc trên files được phân công
- Commit thường xuyên với message rõ ràng
- Test build sau mỗi thay đổi lớn

### 3. Integration (Đạt - Leader)
- Merge các modules
- Kiểm tra tích hợp
- Fix conflicts nếu có

### 4. Testing (Tất cả)
```bash
./scripts/build.sh
./scripts/test-qemu.sh
```

---

## 📝 Git Commit Convention

```
[Module] Mô tả ngắn gọn

VD:
[Calculator] Add Newton-Raphson sqrt algorithm
[Editor] Implement file search by name
[Clock] Fix BCD to decimal conversion
[Game] Add win detection for diagonals
[Terminal] Add 'ver' command
```

---

## 🎯 Tiêu Chí Đánh Giá

### Theo Mức Độ Khó

| Mức Độ | Tiêu Chí |
|--------|----------|
| ⭐⭐⭐⭐⭐ | Thuật toán phức tạp, kiến trúc hệ thống |
| ⭐⭐⭐⭐ | Data structures, memory management |
| ⭐⭐⭐ | BIOS interrupts, conversion algorithms |
| ⭐⭐ | Logic conditions, state management |
| ⭐ | Basic I/O, string handling, UI |

---

<div align="center">

**Phân công được thiết kế công bằng dựa trên khả năng và kinh nghiệm của từng thành viên**

Made by **Nhóm 15** - HDH 2025

</div>
