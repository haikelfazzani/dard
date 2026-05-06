# Dard

⭐ **Dard** is a French educational programming language, designed as an instrument for learning 💻

## Overview

Dard is a complete custom programming language built from scratch to serve as an educational tool for learning compiler design and language implementation. It combines Lex, Yacc, and C to create a full-featured language system.

## Language Composition

| Language | Percentage |
|----------|-----------|
| C        | 94%       |
| Yacc     | 3.7%      |
| Lex      | 1.4%      |
| Makefile | 0.9%      |

## Features

### Data Types
- **entier** - Integer type
- **flottant** - Floating-point numbers
- **chaine** - String type
- **booleen** - Boolean (vrai/faux)
- **tableau** - Arrays

### Control Structures
- **if/else** - Conditional statements (`si`, `sinon`, `finsi`)
- **while** - While loops (`tant`, `faire`, `fintant`)
- **for** - For loops (`pour`, `finpour`)

### Functions
```dard
fonction nomFonction(param1, param2)
  entier resultat;
  resultat = param1 + param2;
  retour resultat;
fin_fonction
```

### Operators
- Arithmetic: `+`, `-`, `*`, `/`, `%`, `^` (power)
- Comparison: `==`, `!=`, `<`, `>`, `<=`, `>=`
- Logical: `et` (AND), `ou` (OR), `non` (NOT)

### Built-in Functions
- **ecrire()** - Print/output values
- **lire()** - Read/input values
- **exit** - Exit program

## Example Programs

### Hello World with Output
```dard
programme
  ecrire(42);
fin
```

### Variables and Arithmetic
```dard
programme
  entier a;
  entier b;
  a = 10;
  b = 20;
  ecrire(a + b);
fin
```

### If/Else Statement
```dard
programme
  entier x;
  x = 15;
  
  si (x > 10)
  {
    ecrire(1);
  }
  sinon
  {
    ecrire(0);
  }
  finsi
fin
```

### For Loop
```dard
programme
  entier i;
  entier sum;
  sum = 0;
  
  pour (i = 0; i < 10; i = i + 1)
  {
    sum = sum + i;
  }
  finpour
  
  ecrire(sum);
fin
```

### While Loop
```dard
programme
  entier x;
  x = 5;
  
  tant (x > 0)
  faire
  {
    ecrire(x);
    x = x - 1;
  }
  fintant
fin
```

### Arrays
```dard
programme
  tableau arr[5];
  entier i;
  
  pour (i = 0; i < 5; i = i + 1)
  {
    arr[i] = i * 2;
  }
  finpour
fin
```

### Functions
```dard
programme
  fonction ajouter(a, b)
  {
    entier resultat;
    resultat = a + b;
    retour resultat;
  }
  fin_fonction
  
  entier somme;
  somme = ajouter(5, 3);
  ecrire(somme);
fin
```

## Build & Run

```shell
yacc -d parser.y && lex lexer.l && gcc -g lex.yy.c y.tab.c -o out.dard -lm
./out.dard < tests/program.dard
```

Note: The `-lm` flag is required to link the math library for power operations.

### Clean Build
```shell
rm -rf lex.yy.c y.tab.c y.tab.h out.dard out.dSYM
```

## Language Design

The language is implemented using:
- **Lex** - Lexical analyzer for tokenization
  - Handles keywords, identifiers, numbers, operators
  - Supports comments starting with `#`
  - French keywords for educational purposes

- **Yacc** - Parser generator for syntax analysis
  - Builds abstract syntax trees
  - Handles expressions, statements, and control flow
  - Manages variable scoping and function definitions

- **C** - Core implementation language
  - Variable storage and management
  - Function implementation
  - Runtime execution engine

## Implementation Details

### Symbol Table
- Stores up to 1000 variables with type information
- Supports multiple data types with proper type checking
- Includes array support with dynamic sizing

### Stack-based Variables
- All variables are stored in a global symbol table
- Type conversion handled automatically where appropriate
- Array elements stored contiguously in memory

### Execution
- Single-pass interpreter
- Expressions evaluated left-to-right
- Control flow statements fully supported

## Topics

`c` `clang` `cpp` `french` `language` `programming-language` `tdd` `compiler` `interpreter` `educational`

## Getting Started

1. Install Yacc and Lex on your system:
   ```bash
   # Ubuntu/Debian
   sudo apt-get install bison flex

   # macOS
   brew install bison flex
   ```

2. Write a Dard program (see examples above)

3. Compile and run:
   ```bash
   yacc -d parser.y && lex lexer.l && gcc -g lex.yy.c y.tab.c -o out.dard -lm
   ./out.dard < yourprogram.dard
   ```

## License

This project is open source and available on GitHub.

---

Created: October 25, 2022  
Last Updated: May 6, 2026  
Repository: [github.com/haikelfazzani/dard](https://github.com/haikelfazzani/dard)
