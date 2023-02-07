#include<stdio.h>

/* Title: Demo code for CSE 031 Lecture 08 (Fall 2021)
 * Author: Santosh Chandrasekhar
 * 
 *
 * This program produces 1 warning during compilation, and causes a Segmentation fault (core dumped).
 * The program might not cause the same runtime error in your system and exhibit odd behavior due to 
 * the reference to freed memory in main() (i.e., the reference in main() to the location of variable 
 * y in the stack frame that gets popped when ptr() returns).
 */

int *ptr () {
    int y;
    y = 3;
    return &y;
}

int main(void) { 
    int *stackAddr, content;
    stackAddr = ptr();
    content = *stackAddr;
    printf("%d", content);
    content = *stackAddr;
    printf("%d", content);
    
    return 0;
} 
