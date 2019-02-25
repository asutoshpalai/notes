#include <stdio.h>

typedef struct {
	int *a;
	int b;
	int c;
} node;

int main() {
	int x = 1, y = 2, z = 3;
	node * n = malloc(sizeof(node));
	n->a = &z;
	n->b = y;
	n->c = 4;
	printf("%d %d %d\n", *n, x);
	printf("%d %d\n", *n->a, x);
	int arr[] = {1, 2, 3, 4, 5, 6};
	printf("%d %d %d", *n);
	return 0;
}
