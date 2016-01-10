NAME = libsparse
SOURCES = backed_block.c output_file.c sparse.c sparse_crc32.c sparse_err.c sparse_read.c
SOURCES := $(foreach source, $(SOURCES), libsparse/$(source))
CFLAGS += -fPIC
CPPFLAGS += -include android/arch/AndroidConfig.h -Iinclude -Ilibsparse/include
LDFLAGS += -shared -Wl,-soname,$(NAME).so.0 \
           -Wl,-rpath=/usr/lib/android -lz

build: $(SOURCES)
	$(CC) $^ -o $(NAME).so.0 $(CFLAGS) $(CPPFLAGS) $(LDFLAGS)
	ln -s $(NAME).so.0 $(NAME).so

clean:
	$(RM) $(NAME).so*