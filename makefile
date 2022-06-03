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
	$(BUILD)/$(listTest_target)
ioTest: $(BUILD)/$(ioTest_target)
	$(BUILD)/$(ioTest_target)
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
	echo 'input'
	echo '----------'
	echo -e '$(1)'
	echo '----------'
	echo 'output'
	echo '----------'
	echo '$(1)'| $(BUILD)/Player.exe
	echo '----------'
	if [ "$(shell echo '$(1)' | ./$(BUILD)/Player.exe)"=="$(2)" ]; then \
		echo "=> PASS";\
		echo "";\
	else 						\
		echo "FAIL - Expected: $(2), Actual: $(shell echo '$(1)' | ./$(BUILD)/Player.exe)";	 \
		exit 1; 				\
	fi;
endef

playerTest: TC1_INP := 3\nHello\nEnemy\nabc\n3\nadd Run\nlist\nquit
playerTest: TC1_OUT := linkedList [ Run abc Enemy Hello ] LinkedList is cleared! quit!
playerTest: TC2_INP := 1\nLevitating\n4\nlist\nplay\nclear\nquit
playerTest: TC2_OUT := LinkedList [ Levitating ] Levitating is now playing! LinkedList is cleared! LinkedList is cleared! quit!
playerTest: TC3_INP := 3\nHello\nEnemy\nabc\n14\nlist\nplay\nnext\nplay\nadd Sunshine\nadd Run\nlist\nnext\nnext\nnext\nnext\nnext\nplay\nquit
playerTest: TC3_OUT := LinkedList [ abc Enemy Hello ] abc is now playing! Enemy is now playing! LinkedList [ Run Sunshine abc Enemy Hello ] Hello is now playing! LinkedList is cleared! quit!

playerTest:
	@$(call test_case,$(TC1_INP),$(TC1_OUT))
	@$(call test_case,$(TC2_INP),$(TC2_OUT))
	@$(call test_case,$(TC3_INP),$(TC3_OUT))
