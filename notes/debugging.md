# Debug 技巧

## QEMU monitor
- `Ctrl-A` → `C` 進 monitor，再按一次切回 console
- `info registers`：看 `pc`、`sp`、CSR
- `xp /4wx 0x80200000`：看實體記憶體
- `stop` / `cont`

## LLVM 工具
- `llvm-objdump -d kernel.elf`：反組譯，對照 pc
- `llvm-addr2line -e kernel.elf <addr>`：位址 → 原始碼行號
- `llvm-nm kernel.elf | grep <symbol>`：查符號位址

## 常見問題紀錄
| 現象 | 原因 | 解法 |
|------|------|------|
|      |      |      |
