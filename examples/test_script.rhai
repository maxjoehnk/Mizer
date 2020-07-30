fn main() {
    if state.i == () {
        state.i = 0.0;
    }
    state.i = state.i + 1.0;
    if state.i >= 255.0 {
        state.i = 0.0;
    }
    state.i
}
