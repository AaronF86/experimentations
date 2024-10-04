import java.util.Random;

enum Status {
    ALIVE,
    DEAD;

    @Override
    public String toString() {
        return this == ALIVE ? "■" : " ";
    }
}

class Grid {
    private final int rows;
    private final int cols;
    private Status[][] grid;

    public Grid(int rows, int cols) {
        Random random = new Random();
        this.rows = rows;
        this.cols = cols;
        this.grid = new Status[rows][cols];
        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                this.grid[i][j] = random.nextBoolean() ? Status.ALIVE : Status.DEAD;
            }
        }
    }


    public void printGrid() {
        System.out.println("--------------------");
        for (int i = 0; i < this.rows; i++) {
            for (int j = 0; j < this.cols; j++) {
                System.out.print("\033[H\033[2J");
                System.out.flush();

                System.out.print(this.grid[i][j].toString());
                System.out.print(" ");
            }
            System.out.println();
        }
    }

    public int countAliveNeighbours(int row, int col) {
        int count = 0;
        for (int i = row - 1; i <= row + 1; i++) {
            for (int j = col - 1; j <= col + 1; j++) {
                // Skip counting the center cell itself
                if (i == row && j == col) continue;

                if (i >= 0 && i < this.rows && j >= 0 && j < this.cols) {
                    if (this.grid[i][j] == Status.ALIVE) {
                        count++;
                    }
                }
            }
        }
        return count;
    }

    public void update() {
        Status[][] newGrid = new Status[this.rows][this.cols];

        for (int y = 0; y < this.rows; y++) {
            for (int x = 0; x < this.cols; x++) {
                int aliveNeighbours = countAliveNeighbours(y, x);
                if (this.grid[y][x] == Status.ALIVE) {
                    if (aliveNeighbours < 2 || aliveNeighbours > 3) {
                        newGrid[y][x] = Status.DEAD;
                    } else {
                        newGrid[y][x] = Status.ALIVE;
                    }
                } else {
                    if (aliveNeighbours == 3) {
                        newGrid[y][x] = Status.ALIVE;
                    } else {
                        newGrid[y][x] = Status.DEAD;
                    }
                }
            }
        }
        this.grid = newGrid;
    }
}

public class Main {
    public static void main(String[] args) throws InterruptedException {
        Grid grid = new Grid(10, 10);
        grid.printGrid();
        for (int i = 0; i < 100; i++) {
            Thread.sleep(500);
            grid.update();
            grid.printGrid();
        }
    }


}
