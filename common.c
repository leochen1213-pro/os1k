#include "common.h"

void putchar(char ch);   // 實作在 kernel.c（之後 user 程式會有自己的版本）

void printf(const char *fmt, ...) {
    va_list vargs;
    va_start(vargs, fmt);

    while (*fmt) {
        if (*fmt == '%') {
            fmt++;                      // 跳過 '%'
            switch (*fmt) {             // 看 '%' 後面是什麼
                case '\0':              // '%' 在字串最後一個字
                    putchar('%');
                    goto end;
                case '%':               // "%%" → 印出 '%'
                    putchar('%');
                    break;
                case 's': {             // 字串
                    const char *s = va_arg(vargs, const char *);
                    while (*s) {
                        putchar(*s);
                        s++;
                    }
                    break;
                }
                case 'd': {             // 十進位整數
                    int value = va_arg(vargs, int);
                    unsigned magnitude = value;   // 用 unsigned 存，才能處理 INT_MIN
                    if (value < 0) {
                        putchar('-');
                        magnitude = -magnitude;
                    }

                    unsigned divisor = 1;         // 找出最高位的除數：3 → 1、123 → 100
                    while (magnitude / divisor > 9)
                        divisor *= 10;

                    while (divisor > 0) {         // 從最高位一位一位印
                        putchar('0' + magnitude / divisor);
                        magnitude %= divisor;
                        divisor /= 10;
                    }

                    break;
                }
                case 'x': {             // 十六進位，固定印 8 位數
                    unsigned value = va_arg(vargs, unsigned);
                    for (int i = 7; i >= 0; i--) {
                        unsigned nibble = (value >> (i * 4)) & 0xf;   // 取出 4 bits（0–15）
                        putchar("0123456789abcdef"[nibble]);          // 當作索引查表
                    }
                }
            }
        } else {
            putchar(*fmt);              // 一般字元直接印
        }

        fmt++;
    }

end:
    va_end(vargs);
}
