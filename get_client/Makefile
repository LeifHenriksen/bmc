#ROOT makefile

LIBS = -lm -lpthread -I.

# -maxdepth -> dont recompile .o in the subfolders
SOURCES = $(shell find . -maxdepth 1 -name "*.cpp")
ALL_SOURCES = $(shell find . -name "*.cpp")

OBJ = $(subst .cpp,.o,$(SOURCES))
ALL_OBJ = $(subst .cpp,.o,$(ALL_SOURCES))

DEPFILES :=  $(shell find . -name "*.h")

FLAGS = -g -Wall -Wextra -pedantic -no-pie -O2 -std=c++11

TARGET = get_client

default: $(TARGET)

$(TARGET): $(OBJ) $(ALL_SOURCES) $(DEPFILES)
	g++ -o $(TARGET) $(FLAGS) $(ALL_OBJ) $(LIBS);

%.o: %.cpp %.h
	g++ -c $(FLAGS) $< $(LIBS)

clean:
	rm -f $(OBJ); rm -f *~; rm $(TARGET)
