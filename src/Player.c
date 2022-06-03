#include <stdio.h>
#include "../include/linkedlist.h"
#include "../include/textfilewriter.h"
#include "Player.h"
#include <string.h>

static Node* cur;

int main() {
	int n;
	int i = 0;
	int temp;
	char buffer[50];

	scanf("%d", &n);

	for (; i < n; ++i) {
		if (1 == scanf("%s", buffer)) {
			append_left(strlen(buffer) + 1, buffer);
		}
	}

	cur = first();

	scanf("%d", &n);


	for (i = 0; i < n; ++i) {
		if (1 != scanf("%s", buffer)) {
			printf("Empty!!!\n");
			break;
		}
		
		if (!strcmp(buffer, "add")) {
			if (1 == scanf("%s", buffer)) {
				add(buffer);
		       	}	
		}
		else if (!strcmp(buffer, "del")) {
			if (1 == scanf("%s", buffer)) {
				del(buffer);
			}
		}
		else if (!strcmp(buffer, "list")) {
			list();
		}
		else if (!strcmp(buffer, "next")) {
			next_node();
		}
		else if (!strcmp(buffer, "prev")) {
			prev_node();
		}
		else if (!strcmp(buffer, "move")) {
			if (1 == scanf("%d", &temp)) {
				move(temp);
			}
		}
		else if (!strcmp(buffer, "play")) {
			play();
		}
        else if (!strcmp(buffer, "clear")) {
            clear();
        }
		else if (!strcmp(buffer, "load")) {
			if (1 == scanf("%s", buffer)) {
				load(buffer);
			}
		}
		else if (!strcmp(buffer, "save")) {
			if (1 == scanf("%s", buffer)) {
				save(buffer);
			}
		}
        else if (!strcmp(buffer, "quit")) {
            clear();
            printf("quit!\n");
        }
		else {
			printf("Invalid command\n");
		}

	}	
}

void add(char* title) {
	append_left(strlen(title) + 1, title);
}

void del(char* title) {
	delete(title);
}

void list() {
	print();
}

void next_node() {
	cur = next();
}

void prev_node() {
	cur = prev();
}

void move(int index) {
	insert_after(get_node(index), cur);
}

void play() {
	printf("%s is now playing!\n", cur->data);
}

void load(char* filename) {
	read_file(filename);
}

void save(char* filename) {
	write_file(filename);
}

