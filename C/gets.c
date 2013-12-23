#include <stdio.h>

int main()
{
	int c;
	while ((c = getchar()) != '\n' && c != EOF) {
		putchar(c);
	}
	putchar('\n');

	exit(0);
}
