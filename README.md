# x86_64 Assembly Calculator

Simple calculator written in x86_64 Assembly for Linux using Linux syscalls.

## Features

- Addition
- Subtraction
- Multiplication
- Division
- Integer parsing
- Integer printing
- Direct Linux syscalls (`read`, `write`, `exit`)

## Syscalls Used

| Syscall | Number |
|---|---|
| read | 0 |
| write | 1 |
| exit | 60 |

## Build Commands

```bash
as asm.s -o asm.o
gcc -o asm asm.o -nostdlib -no-pie
./asm
```
## Output

```text
Type a first number:
10

Type a second number:
5

Type operator (+ - * /):
+

15
```
