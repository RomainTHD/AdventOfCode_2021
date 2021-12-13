/**
 * Position
 */
static class Position {
    /**
     * Row, Y
     */
    public final int row;

    /**
     * Column, X
     */
    public final int col;

    /**
     * Constructor
     *
     * @param row Row
     * @param col Column
     */
    public Position(int row, int col) {
        this.row = row;
        this.col = col;
    }

    /**
     * Get the coordinate according to the axis
     *
     * @param axis Axis
     * @return Coordinate
     */
    public int getAxisCoord(int axis) {
        if (axis == X) {
            return this.col;
        } else {
            return this.row;
        }
    }

    /**
     * Flip the position around the axis
     *
     * @param fold Fold
     * @return Position flipped
     */
    public Position flip(Fold fold) {
        int pos = this.getAxisCoord(fold.axis);
        int offset = abs(pos - fold.getAxisCoord());
        pos -= offset * 2;

        if (fold.axis == X) {
            return new Position(this.row, pos);
        } else {
            return new Position(pos, this.col);
        }
    }

    /**
     * @return String representation
     */
    @Override
    public String toString() {
        return this.row + "," + this.col;
    }

    /**
     * @param other Other
     * @return this == other
     */
    @Override
    public boolean equals(Object other) {
        if (other instanceof Position) {
            return ((Position) other).row == this.row && ((Position) other).col == this.col;
        }

        return false;
    }

    /**
     * @return Hashcode
     */
    @Override
    public int hashCode() {
        return this.toString().hashCode();
    }
}

/**
 * Fold
 */
static class Fold extends Position {
    /**
     * X axis
     */
    public static final int X = 0;

    /**
     * Y axis
     */
    public static final int Y = 1;

    /**
     * Axis
     */
    public final int axis;

    /**
     * Constructor
     *
     * @param row  Row
     * @param col  Column
     * @param axis Axis, X or Y
     */
    private Fold(int row, int col, int axis) {
        super(row, col);
        this.axis = axis;
    }

    /**
     * Constructor from X axis
     *
     * @param col Column
     * @return Fold
     */
    public static Fold fromX(int col) {
        return new Fold(-1, col, X);
    }

    /**
     * Constructor from Y axis
     *
     * @param row Row
     * @return Fold
     */
    public static Fold fromY(int row) {
        return new Fold(row, -1, Y);
    }

    /**
     * @return Coordinate according to the axis
     */
    public int getAxisCoord() {
        return this.getAxisCoord(this.axis);
    }
}

/**
 * Grid
 */
class Grid {
    /**
     * Internal grid representation
     */
    private final HashMap<Position, Boolean> _grid;

    /**
     * Folds
     */
    private final ArrayList<Fold> _folds;

    /**
     * Number of rows
     */
    private int _rows;

    /**
     * Number of columns
     */
    private int _cols;

    /**
     * Constructor
     */
    public Grid() {
        this._grid = new HashMap<>();
        this._folds = new ArrayList<>();
        this._rows = 0;
        this._cols = 0;
    }

    /**
     * Add a position to the grid
     *
     * @param p Position
     */
    public void addPosition(Position p) {
        this._grid.put(p, true);

        if (p.row >= this._rows) {
            this._rows = p.row + 1;
        }

        if (p.col >= this._cols) {
            this._cols = p.col + 1;
        }
    }

    /**
     * Add a fold to the grid
     *
     * @param f Fold
     */
    public void addFold(Fold f) {
        this._folds.add(f);
    }

    /**
     * Fold the grid
     *
     * @return Folded grid or not
     */
    public boolean fold() {
        if (this._folds.isEmpty()) {
            return false;
        }

        Fold f = this._folds.get(0);
        this._folds.remove(0);

        HashMap<Position, Boolean> newGrid = new HashMap<>();

        for (HashMap.Entry<Position, Boolean> entry : this._grid.entrySet()) {
            Position p = entry.getKey();
            if (p.getAxisCoord(f.axis) > f.getAxisCoord()) {
                p = p.flip(f);
            }

            newGrid.put(p, true);
        }

        _grid.clear();
        _grid.putAll(newGrid);

        return true;
    }

    /**
     * @return Grid size
     */
    public int size() {
        return this._grid.size();
    }

    /**
     * @return String representation
     */
    @Override
    public String toString() {
        StringBuilder s = new StringBuilder();

        for (int row = 0; row < this._rows; ++row) {
            for (int col = 0; col < this._cols; ++col) {
                if (this._grid.containsKey(new Position(row, col))) {
                    s.append("#");
                } else {
                    s.append(".");
                }
            }
            s.append("\n");
        }

        return s.toString();
    }
}

/**
 * Loads the data
 *
 * @param filePath File path
 * @return Data loaded
 */
Grid loadData(String filePath) {
    Grid grid = new Grid();
    boolean posMode = true;

    String[] lines = loadStrings(filePath);
    for (String line : lines) {
        if (line.isEmpty()) {
            posMode = false;
            continue;
        }

        if (posMode) {
            String[] components = line.split(",");
            grid.addPosition(new Position(Integer.parseInt(components[1]), Integer.parseInt(components[0])));
        } else {
            String cmd = line.split(" ")[2];
            String[] components = cmd.split("=");
            Fold f;

            if (components[0].charAt(0) == 'x') {
                f = Fold.fromX(Integer.parseInt(components[1]));
            } else {
                f = Fold.fromY(Integer.parseInt(components[1]));
            }

            grid.addFold(f);
        }
    }

    return grid;
}

/**
 * Processing setup, our main
 */
void setup() {
    Grid grid = loadData("./input");

    println("Part 1:");
    println(part1(grid));
    println("Part 2:");
    println(part2(grid));
    println("OK");
    exit();
}

/**
 * Processing draw, we don't care
 */
void draw() {
}
