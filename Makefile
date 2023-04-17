SRCDIR=src
INCDIR=include
BUILDDIR=build
OBJDIR=obj

SRC = $(wildcard $(SRCDIR)/*.s)

EXTERNALS = $(wildcard ../obj/*.o)

VIRTUALS = /usr/lib/aarch64-linux-gnu/libc.so -dynamic-linker /lib/ld-linux-aarch64.so.1

OBJ=$(patsubst $(SRCDIR)/%.s,$(OBJDIR)/%.o,$(SRC))

DEBUG_FLAGS = -g

CC = as $(DEBUG_FLAGS)

LD = ld -lc -lm

TARGET = rasm4

all: $(BUILDDIR) $(BUILDDIR)/$(TARGET)

$(BUILDDIR)/$(TARGET): $(OBJ) $(EXTERNALS) 
	$(LD) -o $@ $^ $(VIRTUALS)

$(OBJDIR)/%.o: $(SRCDIR)/%.s
	$(CC) -I $(INCDIR) -o $@ $<

$(BUILDDIR):
	mkdir -p $(BUILDDIR)

clean:
	rm -rf $(BUILDDIR)
