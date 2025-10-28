# Vietnamese Comments - Progress Tracking

## Mục Đích

Chuyển tất cả comments trong project sang tiếng Việt để giúp các thành viên (đặc biệt là Chiến) hiểu code tốt hơn và học Assembly hiệu quả.

## Tiến Độ

### ✅ Hoàn Thành

- [x] `kernel/apps/terminal.asm` - Comments đầy đủ tiếng Việt
- [x] `kernel/apps/about.asm` - Comments đơn giản tiếng Việt
- [x] `kernel/apps/reboot.asm` - Comments tiếng Việt
- [x] `kernel/utils/screen.asm` - BIOS INT 10h comments tiếng Việt
- [x] `kernel/core/boot.asm` - Boot process tiếng Việt
- [x] `kernel/apps/calculator.asm` - Partial (đã làm 30%)

### 🔄 Đang Làm

- [ ] `kernel/apps/calculator.asm` - Cần hoàn thành 70% còn lại
  - [ ] Newton-Raphson algorithm comments
  - [ ] String to int conversion
  - [ ] Print signed number function

### ⏳ Chưa Làm

- [ ] `boot/boot.asm` - Bootloader (đã có một số tiếng Việt)
- [ ] `kernel/kernel.asm` - Entry point
- [ ] `kernel/apps/editor.asm` - File editor (Khoa)
- [ ] `kernel/apps/game.asm` - Tic Tac Toe (Kiệt)
- [ ] `kernel/apps/clock.asm` - Clock & Calendar (Mạnh)
- [ ] `kernel/core/menu.asm` - Main menu (Kiệt)
- [ ] `kernel/core/data.asm` - Data strings
- [ ] `kernel/utils/keyboard.asm` - Keyboard input (Kiệt)
- [ ] `kernel/utils/string.asm` - String functions (Khoa)
- [ ] `kernel/utils/time.asm` - Time functions (Mạnh)

## Ưu Tiên

### Cao (Giúp Chiến):

1. `terminal.asm` ✅
2. `screen.asm` ✅
3. `boot.asm` (đang có, cần review)
4. `about.asm` ✅
5. `reboot.asm` ✅

### Trung Bình (Giúp Kiệt):

1. `game.asm`
2. `keyboard.asm`
3. `menu.asm`

### Cao (Giúp các thành viên khác):

1. `calculator.asm` (Đạt) - 30% done
2. `editor.asm` (Khoa)
3. `clock.asm` (Mạnh)
4. `string.asm` (Khoa)
5. `time.asm` (Mạnh)

## Ghi Chú Kỹ Thuật

### Cần chuyển đổi:

- `Calculate` → `Tính toán`
- `Display` → `Hiển thị`
- `Input` → `Nhập liệu`
- `Check` → `Kiểm tra`
- `Loop` → `Vòng lặp`
- `Initialize` → `Khởi tạo`
- `Clear` → `Xóa`
- `Set` → `Đặt`
- `Get` → `Lấy`
- `Read` → `Đọc`
- `Write` → `Ghi`
- `Draw` → `Vẽ`
- `Print` → `In`
- `Convert` → `Chuyển đổi`
- `Return` → `Trả về`

### Giữ nguyên tiếng Anh:

- Tên hàm/label
- Register names (AX, BX, CX, DX)
- BIOS interrupt numbers (INT 10h, INT 16h)
- Stack, segment
- Technical terms chuẩn

## Checklist Cho Mỗi File

- [ ] Comments mô tả mục đích file
- [ ] Comments cho từng function
- [ ] Inline comments cho logic phức tạp
- [ ] Comments giải thích BIOS interrupts
- [ ] Comments cho các tham số input/output
- [ ] Comments warning/note cho edge cases
