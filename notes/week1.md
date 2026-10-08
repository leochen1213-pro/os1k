# Week 1｜環境 + 開機（ch01–07）

## ch01 環境
- [ ] `./scripts/check-env.sh` 全部通過
- 遇到的問題：

## ch02 RISC-V 101
- 暫存器：`a0–a7`（參數/回傳）、`ra`、`sp`、`t*`（caller-saved）、`s*`（callee-saved）
- CSR 指令：`csrr` / `csrw`
- 特權模式：M / S / U
- RISC-V vs ARM（BBB 的 Cortex-A8）差異：
  - 

## ch03 總覽
- 最終檔案結構與各檔案職責：

## ch04 啟動（Booting）
- run.sh 每個 CFLAGS 的用途：
  - `-std=c11`：
  - `-O2`：
  - `-g3`：
  - `-Wall -Wextra`：
  - `--target=riscv32-unknown-elf`：
  - `-fno-stack-protector`：
  - `-ffreestanding`：
  - `-nostdlib`：
- kernel.ld：各 section 放哪、`__bss`、`__stack_top` 怎麼來
- `boot` 做了什麼：

## ch05 Hello World!
- SBI call（`ecall`）的參數怎麼傳：

## ch06 libc
- 

## ch07 Kernel Panic
- 

## 面試題自我檢查
- [ ] 上電後到 `kernel_main()` 之前發生了什麼？
- [ ] 為什麼 kernel 要自己清 `.bss`？
- [ ] OpenSBI 的角色？跟 U-Boot / BIOS 的對應？
