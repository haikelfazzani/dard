# Dard

⭐ **Dard** is a French educational programming language, designed as an instrument for learning 💻

## Overview

Dard is a custom programming language built from scratch to serve as an educational tool for learning compiler design and language implementation. It combines multiple technologies to create a complete language system.

## Language Composition

| Language | Percentage |
|----------|-----------|
| C        | 94%       |
| Yacc     | 3.7%      |
| Lex      | 1.4%      |
| Makefile | 0.9%      |

## Build & Run

```shell
yacc -d parser.y && lex lexer.l && gcc -g lex.yy.c y.tab.c -o out.dard
rm -rf lex.yy.c y.tab.c y.tab.h out.dard out.dSYM
./out.dard < tests/stmt
```

## Language Design

The language is implemented using:
- **Lex** - Lexical analyzer for tokenization
- **Yacc** - Parser generator for syntax analysis
- **C** - Core implementation language

## Topics

- `c` `clang` `cpp`
- `french` `language`
- `programming-language` `tdd`

## Getting Started

1. Install Yacc and Lex on your system
2. Run the build commands above
3. Execute the compiled `out.dard` with input from test files

---

Created: October 25, 2022  
Repository: [github.com/haikelfazzani/dard](https://github.com/haikelfazzani/dard)
