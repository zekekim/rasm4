SRCDIR=src
INCDIR=include
BUILDDIR=build

SRC = $(wildcard $(SRCDIR)/*.s)

OBJ=$(patsubst $(SRCDIR)/%.s,$(BUILDDIR)/%.o,$(SRC))

DEBUG_FLAGS = -g

CC = as $(DEBUG_FLAGS)

LD = ld -lc -lm

TARGET=driver

all: $(TARGET)

$(TARGET): $(OBJ)
	$(LD) -o $(OBJ) $(BUILDDIR)/$(TARGET) /usr/lib/aarch64-linx-gnu/libc.so -dynamic-linker /lib/ld-linux-aarch64.so.1

$(BUILDDIR)/%.o: $(SRDIR)/%.s | $(BUILDDIR)
	$(CC) -I $(INCDIR) -c $< -o $@

$(BUILDDIR):
	mkdir $(BUILDDIR)

clean:
	rm-rf $(BUILDDIR) $(TARGET)
