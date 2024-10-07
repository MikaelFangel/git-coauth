.PHONY: all clean

TARGET = git-coauth
SRC = main.pl

all: $(TARGET)

$(TARGET): $(SRC)
		swipl -O -q -g main -t halt -o $(TARGET) -c $(SRC)

clean:
		rm -f $(TARGET)

