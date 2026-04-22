# Makefile

CC = gcc
CFLAGS = -Wall

# Source files
SRCS = main.c utils.c

# Executable name
EXEC = my_program

# Compilation rule
$(EXEC): $(SRCS)
	$(CC) $(CFLAGS) -o $@ $^

# Run target
run: $(EXEC)
	./$(EXEC)

# Clean up
clean:
	rm -f $(EXEC)