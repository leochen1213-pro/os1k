# os1k — Operating System in 1,000 Lines

跟著 [OS in 1,000 Lines](https://operating-system-in-1000-lines.vercel.app/tw/)（作者：Seiya Nuta）從零打造一個 RISC-V 32-bit 小型作業系統，在 QEMU 上執行。

目標：理解作業系統核心機制（開機、trap、context switch、分頁、system call、驅動），並對照 Linux kernel driver 與 FreeRTOS 的實作。

## 環境

主要開發環境：Ubuntu 24.04 VM（VMware Fusion）

```bash
sudo apt install -y clang llvm lld qemu-system-misc curl
curl -LO https://github.com/qemu/qemu/raw/v8.0.4/pc-bios/opensbi-riscv32-generic-fw_dynamic.bin
```

也支援 macOS（Apple Silicon）：`brew install llvm lld qemu`（需用 Homebrew 的 clang，Apple 內建的不支援 riscv32）。`run.sh` 會自動判斷 OS。

檢查環境：`./scripts/check-env.sh`

## 執行

```bash
./run.sh
```

離開 QEMU：`Ctrl-A` 再按 `X`；進 QEMU monitor：`Ctrl-A` 再按 `C`。

## 進度

### Week 1｜環境 + 開機
- [ ] 01 開始（環境建置）
- [ ] 02 RISC-V 101
- [ ] 03 總覽
- [ ] 04 啟動（Booting）
- [ ] 05 Hello World!
- [ ] 06 C 標準函式庫（libc）
- [ ] 07 核心錯誤處理（Kernel Panic）

### Week 2｜例外與行程
- [ ] 08 例外處理（Exception）
- [ ] 09 記憶體配置
- [ ] 10 行程（Process）

### Week 3｜記憶體與使用者模式
- [ ] 11 分頁表（Page Table）
- [ ] 12 應用程式（Application）
- [ ] 13 使用者模式（User Mode）
- [ ] 14 系統呼叫（System Call）

### Week 4｜驅動與檔案系統
- [ ] 15 虛擬磁碟 I/O（VirtIO Block）
- [ ] 16 檔案系統（File System）
- [ ] 17 總結

### Week 5｜延伸
- [ ] Timer interrupt + 搶占式排程
- [ ] Page free / 行程結束回收記憶體

## 檔案結構（完成時）

```
.
├── run.sh          # 建置並在 QEMU 執行
├── kernel.c/.h     # 核心
├── kernel.ld       # 核心 linker script
├── common.c/.h     # kernel 與 user 共用（printf、memcpy…）
├── user.c/.h       # user 程式的 runtime
├── user.ld         # user 程式 linker script
├── shell.c         # 命令列 shell（user 程式）
├── disk/           # 打包成 tar 當作磁碟內容
├── notes/          # 每週學習筆記
└── scripts/        # 輔助腳本
```

## 筆記

- [Week 1](notes/week1.md)
- [Debug 技巧](notes/debugging.md)

## License

教材本體為 CC BY 4.0，範例程式碼為 MIT。本 repo 程式碼為學習用途自行撰寫。
