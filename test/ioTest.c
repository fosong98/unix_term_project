#include "../include/textfilewriter.h"
#include "../include/linkedlist.h"
#include <string.h>
#include <stdlib.h>
#include <assert.h>

void verify_input(char*[], int);
void verify_output(char* file_name, char*[], int);

int main() {
	char* test_case1[6] = { "music_1", "music_2", "music_3", "music_4", "music_5", "music_6" };
    char* test_case2[6] = { "5", "music_6", "music_5", "music_2", "music_4", "music_3" };


	// read_file test
	read_file("test/test_text");
	verify_input(test_case1, 6);

	insert_after(get_node(1), get_node(3));
	delete("music_1");
	
	write_file("test/test_text2");

	verify_output("test/test_text2", test_case2, 6);
	
}

void verify_input(char* answer[], int length) {
	Node* cur = first();
	int i;

	printf("Testing Input\n...\n");
	assert(length == size());

	for (i = 0; i < length; ++i) {
		assert(strcmp(answer[i], cur->data) == 0);
		cur = cur->next;
	}

	printf("Ok.\n\n");
}

void verify_output(char* file_name, char* answer[], int count) {
    FILE *f = fopen(file_name, "r");
    char buffer[50];
    int i;
    printf("Testing Output\n...\n");
    for (i = 0; i < count; ++i) {
        fgets(buffer, 50, f);
        assert(i < count && strcmp(answer[i], buffer));
    }

    printf("Ok.\n\n");
	fclose(f);
}


