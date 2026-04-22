#include <stdio.h>

// Function to print error messages
void print_error(const char *message) {
    fprintf(stderr, "Error: %s\n", message);
}

// Function to validate a symbol
int validate_symbol(const char *symbol) {
    // Sample validation: check if the symbol is not NULL and not empty
    return (symbol != NULL && symbol[0] != '\0');
}

// Function to debug a token
void debug_token(const char *token) {
    printf("Debug Token: %s\n", token);
}