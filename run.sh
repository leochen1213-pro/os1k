#!/bin/bash
set -xue

# QEMU
QEMU=qemu-system-riscv32

# 依 OS 選 clang
#   macOS：必須用 Homebrew 的 clang（Apple 內建的不支援 riscv32）
#   Linux（Ubuntu VM）：系統的 clang 即可
if [ "$(uname)" = "Darwin" ]; then
    CC=/opt/homebrew/opt/llvm/bin/clang
else
    CC=clang
fi

# Linux 需要 repo 根目錄有 OpenSBI（macOS 的 Homebrew QEMU 已內建）
if [ "$(uname)" != "Darwin" ] && [ ! -f opensbi-riscv32-generic-fw_dynamic.bin ]; then
    echo "找不到 opensbi-riscv32-generic-fw_dynamic.bin，請先下載到 repo 根目錄" >&2
    exit 1
fi

# Add
CFLAGS="-std=c11 -O2 -g3 -Wall -Wextra --target=riscv32-unknown-elf -fuse-ld=lld -fno-stack-protector -ffreestanding -nostdlib"

# Add
# 編譯
$CC $CFLAGS -Wl,-Tkernel.ld -Wl,-Map=kernel.map -o kernel.elf kernel.c

# TODO(ch04): 依書上內容補上 CFLAGS、編譯 kernel.elf、啟動 QEMU 的指令
# 自己打一遍，並在 notes/week1.md 記下每個 flag 的用途
#$QEMU -machine virt -bios default -nographic -serial mon:stdio --no-reboot
$QEMU -machine virt -bios default -nographic -serial mon:stdio --no-reboot -kernel kernel.elf

