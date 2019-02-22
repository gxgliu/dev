#include <stdio.h>
#include <stdlib.h>
#include <time.h>

// 求める素数の最大値
#define MAX 1000000

int main(int argc, char *argv[])
{
	int prime;
	int num;
	int limit; // 第1参数，指定求前几位素数
	char isEnough = 0; // 到达指定素数个数后退出循环
	int count = 0;
	clock_t start, end, delta;

	if (argv[1] != NULL) {
		limit = atoi(argv[1]);
	}

	// 時間計測開始
	start = clock();

	// 素数を求める
	for (prime = 2; isEnough == 0 && prime <= MAX; prime++) {
		for (num = 2; num <= prime; num++) {
			if (prime == num) {
				printf("%d ", prime);
				count++;
				if (count == limit) isEnough = 1;
			} else if (prime % num == 0) {
				break;
			}
		}
	}
	printf("\n");

	// 時間計測終了
	end = clock();
	// かかった時間
	delta = end - start;

	// 結果を表示
	printf("素数の数は%d個。\n", count);
	printf("計算時間は%lf秒。\n", (double)(delta) / CLOCKS_PER_SEC);

	return 0;
}
