ENTRY(boot)

SECTIONS {
    . = 0x80200000;              /* 從這個位址開始放 */

    .text :{
        KEEP(*(.text.boot));     /* boot() 一定排第一個，所以會落在 0x80200000 */
        *(.text .text.*);        /* 其他程式碼 */
    }

    .rodata : ALIGN(4) {
        *(.rodata .rodata.*);    /* 唯讀常數，例如字串 */
    }

    .data : ALIGN(4) {
        *(.data .data.*);        /* 有初始值的全域變數 */
    }

    .bss : ALIGN(4) {
        __bss = .;               /* 記下 .bss 的起點 */
        *(.bss .bss.* .sbss .sbss.*);
        __bss_end = .;           /* 記下 .bss 的終點 */
    }

    . = ALIGN(4);
    . += 128 * 1024;             /* 往後空出 128KB 當 stack */
    __stack_top = .;             /* stack 的「頂端」，也就是這塊區域的最高位址 */
}
