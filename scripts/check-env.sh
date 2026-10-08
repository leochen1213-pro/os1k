#!/bin/bash
# 檢查 os1k 開發環境是否就緒（macOS / Linux 皆可）
set -u

cd "$(dirname "$0")/.."

if [ "$(uname)" = "Darwin" ]; then
    OS=macOS
    CLANG=/opt/homebrew/opt/llvm/bin/clang
else
    OS=Linux
    CLANG=clang
fi

ok=0
check() {
    if eval "$2" >/dev/null 2>&1; then
        echo "  [OK]   $1"
    else
        echo "  [FAIL] $1"
        ok=1
    fi
}

echo "== os1k environment check ($OS) =="
check "clang 存在 ($CLANG)"          "command -v $CLANG"
check "clang 支援 riscv32"           "$CLANG -print-targets | grep -q riscv32"
check "ld.lld 可用"                  "command -v ld.lld"
check "llvm-objcopy 在 PATH"         "command -v llvm-objcopy"
check "llvm-objdump 在 PATH"         "command -v llvm-objdump"
check "llvm-addr2line 在 PATH"       "command -v llvm-addr2line"
check "llvm-nm 在 PATH"              "command -v llvm-nm"
check "qemu-system-riscv32 可用"     "command -v qemu-system-riscv32"
if [ "$OS" = "Linux" ]; then
    check "OpenSBI 在 repo 根目錄"    "test -f opensbi-riscv32-generic-fw_dynamic.bin"
fi

echo
if [ $ok -eq 0 ]; then
    echo "全部通過，可以開始 ch04！"
    qemu-system-riscv32 --version | head -n1
elif [ "$OS" = "macOS" ]; then
    echo "提示：brew install llvm lld qemu，並把 \$(brew --prefix)/opt/llvm/bin 加進 PATH"
else
    echo "提示：sudo apt install -y clang llvm lld qemu-system-misc"
    echo "      找不到 qemu-system-riscv32 的話改試：sudo apt install -y qemu-system-riscv"
    echo "      OpenSBI：curl -LO https://github.com/qemu/qemu/raw/v8.0.4/pc-bios/opensbi-riscv32-generic-fw_dynamic.bin"
fi
exit $ok
