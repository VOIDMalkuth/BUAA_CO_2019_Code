#include <stdio.h>

int array[150], core[150], res[150];

int main(void){
    int m1, n1, m2, n2;
    scanf("%d", &m1);
    scanf("%d", &n1);
    scanf("%d", &m2);
    scanf("%d", &n2);

    for (int i = 0; i < m1; i++)
        for (int j = 0; j < n1; j++)
            scanf("%d", &array[i * n1 + j]);
    for (int i = 0; i < m2; i++)
        for (int j = 0; j < n2; j++)
            scanf("%d", &core[i * n2 + j]);

    for (int i = 0; i < m1 - m2 + 1; i++){
        for (int j = 0; j < n1 - n2 + 1; j++){
            int tmp = 0;
            for (int k = i; k < i + m2; k++)
                for (int l = j; l < j + n2; l++)
                    tmp += array[k * n1 + l] * core[(k - i) * n2 + (l - j)];
            res[i * (n1 - n2 + 1) + j] = tmp;
        }
    }

    for (int i = 0; i < m1 - m2 + 1; i++){
        for (int j = 0; j < n1 - n2 + 1; j++){
            printf("%d ", res[i * (n1 - n2 + 1) + j]);
        }
        putchar('\n');
    }

    return 0;
}