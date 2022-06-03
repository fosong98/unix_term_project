#include <stdlib.h>
#include <string.h>
#include "../include/linkedlist.h"

static Node* _head = NULL;

static Node* _tail = NULL;

static Node* _cur_node = NULL;

static int count = 0;

bool empty() {
    if (_head == NULL)
        return true;
    else
        return false;
}

size_t size() {
    return count;
}

void print() {
    Node* temp = _head;

    printf("linkedList[ ");

    while (temp != NULL) {
        printf("%s ", temp->data);
        temp = temp->next;
    }

    printf("]\n");
}

void print_file(FILE* stream) {
    Node* temp = _tail;

    fprintf(stream, "%d\n", count);

    while (temp != NULL) {
        fprintf(stream, "%s\n", temp->data);
        temp = temp->prev;
    }
}

void clear() {
    Node* c = first();
    Node* t;
    if (c == NULL)
        return;
    while (c->next != NULL)
        c = delete_node(t);
    _cur_node = NULL;
    printf("LinkedList is cleared!\n");
}

Node* append_left(size_t n, char new_data[n]) {
    Node* temp = malloc(sizeof(Node));
    temp->data = malloc(sizeof(n));
    strcpy(temp->data, new_data);

    if (_head == NULL) {
        temp->next = NULL;
        _tail = temp;
    } else {
        first()->prev = temp;
        temp->next = first();
    }
    temp->prev = NULL;
    _head = temp;
    count++;

    return temp;
}

Node* insert_after(Node* cur_node, Node* new_node) {
    Node* left = cur_node->prev;
    Node* right = cur_node->next;

    if (left != NULL)
        left->next = right;
    else
        _head = right;

    if (right != NULL)
        right->prev = left;
    else
        _tail = left;

    if (new_node != NULL) {
        if (new_node->next != NULL)
            new_node->next->prev = cur_node;
        cur_node->prev = new_node;
        cur_node->next = new_node->next;
        new_node->next = cur_node;
        if (cur_node->next == NULL)
            _tail = cur_node;
    }
    return cur_node;
}

Node* append(size_t n, char new_data[n]) {
    Node* temp = malloc(sizeof(Node));
    temp->data = malloc(n + 1);
    strcpy(temp->data, new_data);

    if (_tail == NULL) {
        temp->prev = NULL;
        _head = temp;
    } else {
        last()->next = temp;
        temp->prev = last();
    }
    temp->next = NULL;
    _tail = temp;
    count++;

    return temp;
}

Node* delete_node(Node* cur_node) {
    Node* left = cur_node->prev;
    Node* right = cur_node->next;

    free(cur_node->data);
    free(cur_node);

    if (left == NULL && right == NULL) {
        _head = NULL;
        _tail = NULL;
    } else if (left != NULL && right != NULL) {
        left->next = right;
        right->prev = left;
    } else {
        if (left == NULL) {
            _head = right;
            right->prev = NULL;
        } else {
            _tail = left;
            left->next = NULL;
        }
    }

    count--;

    return right;
}

Node* delete(char* data) {
    Node* temp = first();
    while (temp != NULL) {
        if (!strcmp(temp->data, data)) {
            temp = delete_node(temp);
            return temp;
        }
        temp = temp->next;
    }
    return NULL;
}

Node* get_node(size_t index) {
    int i = 0;
    Node* temp = first();
    if (size() <= index)
        return NULL;
    else {
        while (temp != NULL) {
            if (i == index) {
                _cur_node = temp;
                return temp;
            }

            temp = temp->next;
            ++i;
        }
        return NULL;
    }
}

Node* first() {
    _cur_node = _head;
    return _cur_node;
}

Node* last() {
    _cur_node = _tail;
    return _cur_node;
}

Node* next() {
    if (_cur_node->next != NULL)
        _cur_node = _cur_node->next;
    return _cur_node;
}

Node* prev() {
    if (_cur_node->prev != NULL)
        _cur_node = _cur_node->prev;
    return _cur_node;
}
