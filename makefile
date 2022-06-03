CC := gcc
BUILD := build
LIB := libs
TEST := test
SRC := src

listTest_target = listTest.exe
listTest_obj = $(BUILD)/listTest.o $(BUILD)/linkedlist.o

ioTest_target = ioTest.exe
ioTest_obj = $(BUILD)/ioTest.o $(BUILD)/textfilewriter.o $(BUILD)/linkedlist.o

playerTest_target = Player.exe
playerTest_obj = $(BUILD)/Player.o $(BUILD)/textfilewriter.o $(BUILD)/linkedlist.o

listTest: $(BUILD)/$(listTest_target)
ioTest: $(BUILD)/$(ioTest_target)
playerTest: $(BUILD)/$(playerTest_target)

$(BUILD)/$(listTest_target): $(listTest_obj)
	$(CC) -g $^ -o $@

$(listTest_obj): | $(BUILD)
$(ioTest_obj): | $(BUILD)
$(playerTest_obj): | $(BUILD)

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

$(BUILD)/$(playerTest_target): $(playerTest_obj)
	$(CC) $^ -o $@
$(BUILD)/Player.o: $(SRC)/Player.c
	$(CC) -c $^ -o $@

clear:
	rm -rf $(BUILD)

define test_case
	if [ "$(shell echo -e $(1) | build/Player.exe > log; cat log | tr -d '\n')" == $(2) ]; then \
		echo "PASS"; 				\
	else 						\
		echo "FAIL - Expected: $(2), Actual: $(shell echo '$(1)' | ./$(BUILD)/Player.exe)";	 \
		exit 1; 				\
	fi;
endef

playerTest: TC1_INP := 3\nHello\nEnemy\nabc\n3\nadd Run\nlist\nquit
playerTest: TC1_OUT := LinkedList [ Run abc Enemy Hello ]LinkedList is cleared!quit!
#playerTest: TC2_INP := + 2000000000 2000000000
#playerTest: TC2_OUT := 4000000000
#playerTest: TC3_INP := * 1 2
#playerTest: TC3_OUT := 2
#playerTest: TC4_INP := * 200000 200000
#playerTest: TC4_OUT := 40000000000

playerTest:
	@$(call test_case,$(TC1_INP),$(TC1_OUT))
#	@$(call test_case,$(TC2_INP),$(TC2_OUT))
#	@$(call test_case,$(TC3_INP),$(TC3_OUT))
#	@$(call test_case,$(TC4_INP),$(TC4_OUT))