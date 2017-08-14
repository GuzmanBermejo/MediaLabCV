package gbr.medialabcv;

/**
 * Stores pairs of related data.
 * Created by gbermejo on 11/08/2017.
 */
class Tuple<X> {
    public final X x;
    public final X y;

    public Tuple(X x, X y) {
        this.x = x;
        this.y = y;
    }

    public boolean contains(X x) {
        return this.x == x || this.y == x;
    }
}


