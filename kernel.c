typedef unsigned char uint8_t;
typedef unsigned int uint32_t;
typedef uint32_t size_t;

extern char __bss[], __bss_end[], __stack_top[];   // linker script 定義的符號

void *memset(void *buf, char c, size_t n) {
    uint8_t *p = (uint8_t *) buf;
    while (n--)
        *p++ = c;
    return buf;
}

void kernel_main(void) {
    memset(__bss, 0, (size_t) __bss_end - (size_t) __bss);   // 清 .bss
    for (;;);
}

__attribute__((section(".text.boot")))   // 放進 .text.boot，對應 linker script 的 KEEP
__attribute__((naked))                   // 不要產生 prologue/epilogue
void boot(void) {
    __asm__ __volatile__(
        "mv sp, %[stack_top]\n"          // sp = __stack_top
        "j kernel_main\n"                // 跳過去，不會再回來
        :
        : [stack_top] "r" (__stack_top)
    );
}
