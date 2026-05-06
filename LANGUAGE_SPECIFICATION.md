# Dard Language Specification

## Syntax and Grammar

### Program Structure
```
program := PROGRAM statements FIN
         | statements

statements := statement
            | statements statement
```

### Data Types
- `entier` - Integer (32-bit signed integer)
- `flottant` - Floating-point (double precision)
- `chaine` - String (character array)
- `booleen` - Boolean (vrai/faux)
- `tableau` - Array (fixed size, integer elements)

### Variable Declaration
```
entier nom_variable;
entier nom_variable = valeur;
flottant nom_variable;
chaine nom_variable;
tableau nom_variable[taille];
```

### Operators

#### Arithmetic Operators
| Operator | Symbol | Example | Result |
|----------|--------|---------|--------|
| Addition | + | 5 + 3 | 8 |
| Subtraction | - | 5 - 3 | 2 |
| Multiplication | * | 5 * 3 | 15 |
| Division | / | 6 / 2 | 3 |
| Modulo | % | 7 % 3 | 1 |
| Power | ^ | 2 ^ 3 | 8 |

#### Comparison Operators
| Operator | Symbol | Example | Meaning |
|----------|--------|---------|----------|
| Equal | == | a == b | a is equal to b |
| Not Equal | != | a != b | a is not equal to b |
| Less Than | < | a < b | a is less than b |
| Greater Than | > | a > b | a is greater than b |
| Less or Equal | <= | a <= b | a is less than or equal to b |
| Greater or Equal | >= | a >= b | a is greater than or equal to b |

#### Logical Operators
| Operator | Symbol | Example | Meaning |
|----------|--------|---------|----------|
| AND | et | a et b | both a and b are true |
| OR | ou | a ou b | either a or b is true |
| NOT | non | non a | a is false |

### Assignment
```
identifier = expression;
identifier[index] = expression;  // Array element assignment
```

### Control Structures

#### If Statement
```
si (condition)
{
  statements
}
finsi

si (condition)
{
  statements
}
sinon
{
  statements
}
finsi
```

#### While Loop
```
tant (condition)
faire
{
  statements
}
fintant
```

#### For Loop
```
pour (init; condition; increment)
{
  statements
}
finpour
```

### Functions

#### Function Definition
```
fonction nom_fonction(param1, param2, ...)
{
  variable_declarations
  statements
  retour expression;
}
fin_fonction
```

#### Function Call
```
nom_fonction(arg1, arg2, ...);
variable = nom_fonction(arg1, arg2, ...);
```

### Built-in Functions

#### Output
```
ecrire(expression);  // Print integer to stdout
```

#### Program Control
```
exit;  // Exit program with success code
```

### Arrays

#### Declaration
```
tableau arr[10];  // Declare array of size 10
```

#### Access
```
valeur = arr[index];        // Read element
arr[index] = valeur;        // Write element
```

### Examples

#### Simple Arithmetic
```dard
programme
  entier x;
  entier y;
  entier somme;
  
  x = 10;
  y = 20;
  somme = x + y;
  
  ecrire(somme);
fin
```

#### Conditional Statement
```dard
programme
  entier age;
  age = 25;
  
  si (age >= 18)
  {
    ecrire(1);  # Adult
  }
  sinon
  {
    ecrire(0);  # Minor
  }
  finsi
fin
```

#### Loop - Sum of Numbers
```dard
programme
  entier i;
  entier somme;
  somme = 0;
  
  pour (i = 1; i <= 10; i = i + 1)
  {
    somme = somme + i;
  }
  finpour
  
  ecrire(somme);  # Output: 55
fin
```

#### Function Definition and Call
```dard
programme
  fonction multiplier(a, b)
  {
    entier resultat;
    resultat = a * b;
    retour resultat;
  }
  fin_fonction
  
  entier produit;
  produit = multiplier(6, 7);
  ecrire(produit);  # Output: 42
fin
```

#### Array Operations
```dard
programme
  tableau nombres[5];
  entier i;
  entier somme;
  somme = 0;
  
  pour (i = 0; i < 5; i = i + 1)
  {
    nombres[i] = i * 2;
    somme = somme + nombres[i];
  }
  finpour
  
  ecrire(somme);  # Output: 20
fin
```

## Comments
Comments start with `#` and continue to the end of the line:
```
# This is a comment
entier x;  # Declare variable x
```

## Keywords (French)
All Dard keywords are in French:
- `programme` - Start of program
- `fin` - End of program
- `entier` - Integer type
- `flottant` - Float type
- `chaine` - String type
- `booleen` - Boolean type
- `tableau` - Array type
- `si` - If statement
- `sinon` - Else clause
- `finsi` - End if
- `tant` - While loop
- `faire` - Do (part of while)
- `fintant` - End while
- `pour` - For loop
- `finpour` - End for
- `fonction` - Function definition
- `fin_fonction` - End function
- `retour` - Return statement
- `ecrire` - Print/write output
- `lire` - Read input
- `exit` - Exit program
- `vrai` - True (boolean)
- `faux` - False (boolean)
- `et` - AND operator
- `ou` - OR operator
- `non` - NOT operator

## Type System
Dard uses a simple type system:
- Variables must be declared before use
- Type checking is enforced at parse time
- Automatic type conversion occurs in arithmetic operations
- Arrays are homogeneous (all elements are integers)

## Scope
Variables have function or global scope:
- Global variables are accessible throughout the program
- Function parameters are local to the function
- Return values can be stored in variables

## Limitations
- Single-pass interpreter (no hoisting)
- No dynamic memory allocation
- Arrays have fixed size at declaration
- Strings have limited support
- No nested function definitions
