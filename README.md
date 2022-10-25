# Dard

## 
```shell
yacc -d parser.y && lex lexer.l && gcc -g lex.yy.c y.tab.c -o out.dard
rm -rf lex.yy.c y.tab.c y.tab.h out.dard out.dSYM
./out.dard < tests/stmt
```

## language design
```c

```