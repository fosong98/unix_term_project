CC := gcc
BUILD := build
LIB := libs
TEST := test

listTest_target = listTest.exe
listTest_obj = $(BUILD)/listTest.o $(BUILD)/linkedlist.o

ioTest_target = ioTest.exe
ioTest_obj = $(BUILD)/ioTest.o $(BUILD)/textfilewriter.o $(BUILD)/linkedlist.o

listTest: $(BUILD)/$(listTest_target)
ioTest: $(BUILD)/$(ioTest_target)

$(BUILD)/$(listTest_target): $(listTest_obj)
	$(CC) -g $^ -o $@

$(listTest_obj): | $(BUILD)
$(ioTest_obj): | $(BUILD)

$(BUILD):
	mkdir $(BUILD)


$(BUILD)/listTest.o: $(TEST)/listTest.c
	$(CC) -c $^ -o $@
$(BUILD)/linkedlist.o: $(LIB)/linkedlist.c
	$(CC) -c $^ -o $@


$(BUILD)/$(ioTest_target): $(ioTest_obj)
	$(CC) $^ -o $@
$(BUILD)/ioTest.o: $(TEST)/ioTest.c
	$(CC) -c $^ -o $@
$(BUILD)/textfilewriter.o : $(LIB)/textfilewriter.c
	$(CC) -c $^ -o $@




clear:
	rm -rf $(BUILD)

