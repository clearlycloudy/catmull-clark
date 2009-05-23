CC = gcc
CFLAGS = -O2 -finline-functions -g
CFLAGS += -Wall -Winline -std=gnu99
LDFLAGS += -g
AR = ar
LIBS = -lm -lGL -lGLU -lglut

#
# For debugging, uncomment the next one
#
# CFLAGS += -O0 -DDEBUG -g3 -gdwarf-2

PROGRAMS = catmull-clark

LIB_H = arr.h util.h geometry.h mesh.h
LIB_OBJS = geometry.o mesh.o
LIB_FILE = libsurf.a

LIBS += $(LIB_FILE)

#
# Pretty print
#

V	      = @
Q	      = $(V:1=)
QUIET_CC      = $(Q:@=@echo    '     CC       '$@;)
QUIET_AR      = $(Q:@=@echo    '     AR       '$@;)
QUIET_GEN     = $(Q:@=@echo    '     GEN      '$@;)
QUIET_LINK    = $(Q:@=@echo    '     LINK     '$@;)

all: $(PROGRAMS)

catmull-clark: main.o $(LIB_FILE)
	$(QUIET_LINK)$(CC) $(LDFLAGS) -o $@ $< $(LIBS)

geometry.o: $(LIB_H)
mesh.o: $(LIB_H)
main.o: $(LIB_H)

$(LIB_FILE): $(LIB_OBJS)
	$(QUIET_AR)$(AR) rcs $@ $(LIB_OBJS)

.c.o:
	$(QUIET_CC)$(CC) -o $@ -c $(CFLAGS) $<

clean:
	rm -f *.[oa] *.so $(PROGRAMS) $(LIB_FILE)
