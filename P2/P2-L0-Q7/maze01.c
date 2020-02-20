#include <stdio.h>

int maze[10][10]; // 8bit is fine
int n, m;
int dest_y, dest_x;
int total = 0;

int dfs(int start_y, int start_x);

int main(void){
    scanf("%d %d", &n, &m);
    for (int i = 0; i < n; i++)
        for (int j = 0; j < m; j++)
            scanf("%d", &maze[i][j]);

    int start_x, start_y;
    scanf("%d %d %d %d", &start_y, &start_x, &dest_y, &dest_x);
    start_x = start_x - 1;
    start_y = start_y - 1;
    dest_x = dest_x - 1;
    dest_y = dest_y - 1;

    printf("%d %d", dfs(start_y, start_x), total);

    return 0;
}

int dfs(int start_y, int start_x){
    if (start_x == dest_x && start_y == dest_y){
        total++;
        return 1;
    }

    int path = 0;

    maze[start_y][start_x] = 1;
    if (start_y - 1 >= 0 && maze[start_y - 1][start_x] == 0)
        path += dfs(start_y - 1, start_x);
    if (start_x - 1 >= 0 && maze[start_y][start_x - 1] == 0)
        path += dfs(start_y, start_x - 1);
    if (start_y + 1 < n && maze[start_y + 1][start_x] == 0)
        path += dfs(start_y + 1, start_x);
    if (start_x + 1 < m && maze[start_y][start_x + 1] == 0)
        path += dfs(start_y, start_x + 1);
    maze[start_y][start_x] = 0;

    return path;
}