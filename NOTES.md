# Assembly Notes

## Registers

| Register | Description |
|---|---|
| `rax` | Main accumulator register. Used for syscall numbers and return values. |
| `rbx` | General purpose register. |
| `rcx` | Counter register, often used in loops. |
| `rdx` | Used in division, remainder storage, and syscall arguments. |
| `rsi` | Source index register. Often stores memory addresses/pointers. |
| `rdi` | Destination index register. Often stores function/syscall first argument. |
| `rsp` | Stack pointer. Points to the top of the stack. |
| `rbp` | Base pointer. Used for stack frames. |
| `r12-r15` | General purpose registers usually preserved across function calls. |

---

## Linux x86_64 Syscall Convention

| Register | Purpose |
|---|---|
| `rax` | Syscall number |
| `rdi` | 1st argument |
| `rsi` | 2nd argument |
| `rdx` | 3rd argument |
| `r10` | 4th argument |
| `r8` | 5th argument |
| `r9` | 6th argument |

Example:

```asm
mov rax, 1      # syscall: write
mov rdi, 1      # stdout
mov rsi, buffer # message
mov rdx, 5      # length
syscall
```

---

## Common Syscalls

| Syscall | Number | Description |
|---|---|---|
| `read` | `0` | Read input |
| `write` | `1` | Print output |
| `exit` | `60` | Exit program |

---

## Assembly Sections

| Section | Purpose |
|---|---|
| `.text` | Executable code |
| `.data` | Initialized data |
| `.bss` | Uninitialized memory |

Example:

```asm
.section .text
.section .data
.section .bss
```

---

## Common Instructions

| Instruction | Description |
|---|---|
| `mov` | Copy value |
| `add` | Addition |
| `sub` | Subtraction |
| `imul` | Signed multiplication |
| `div` | Unsigned division |
| `xor` | Bitwise XOR |
| `cmp` | Compare values |
| `jmp` | Unconditional jump |
| `je` | Jump if equal |
| `jne` | Jump if not equal |
| `call` | Call function |
| `ret` | Return from function |
| `inc` | Increment |
| `dec` | Decrement |
| `lea` | Load effective address |
| `syscall` | Execute Linux syscall |

---

## Memory Addressing

### Load value

```asm
mov al, [rsi]
```

Reads memory pointed by `rsi`.

---

### Load address

```asm
lea rsi, [rip + buffer]
```

Loads the address of `buffer` into `rsi`.

---

## Function Calls

```asm
call my_function
```

- Pushes return address onto stack
- Jumps to function

Return:

```asm
ret
```

---

## Stack

| Instruction | Description |
|---|---|
| `push` | Push value to stack |
| `pop` | Remove value from stack |

Stack grows downward in memory.

---

## ASCII

| Character | Value |
|---|---|
| `'0'` | `48` |
| `'1'` | `49` |
| `'9'` | `57` |
| `'\n'` | `10` |

Convert ASCII digit to integer:

```asm
sub bl, '0'
```

---

## Integer Parsing

String:

```text
"123"
```

Conversion logic:

```text
result = result * 10 + digit
```

Assembly:

```asm
imul rax, rax, 10
add rax, rbx
```

---

## Integer Printing

Division by 10:

```asm
div rbx
```

Results:

| Register | Meaning |
|---|---|
| `rax` | Quotient |
| `rdx` | Remainder |

Remainder becomes ASCII digit.

---

## RIP Relative Addressing

```asm
lea rsi, [rip + buffer]
```

Used in modern x86_64 Linux binaries because of PIE/ASLR.

---

## Program Entry Point

```asm
.global _start
```

Defines program entry.

`_start` is the first executed label.

---

## Intel Syntax

```asm
.intel_syntax noprefix
```

Enables Intel syntax without `%` prefixes.

Example:

```asm
mov rax, 1
```

instead of:

```asm
mov $1, %rax
```
