# Mizer

A node based visualization tool for live scenarios (e.g. concerts and clubs).

![Nodes View](docs/screenshots/nodes_view.png)

## Development

### Dependencies

You need to have the following tools installed:

* Rust
* cbindgen
* Flutter SDK
* protoc
* GStreamer
* LLVM

### Building

Run `make build` in the Project root. This will place the `mizer` binary in the `target/debug` folder.

After running `make build` once you can also use all `cargo` commands directly.

### Running

To run just execute the binary or use `make run`.

## Screenshots

### Layout View
![Layout View](docs/screenshots/layout.png)

### Nodes View
![Nodes View](docs/screenshots/nodes_view.png)

### Sequencer View
![Sequencer View](docs/screenshots/sequencer.png)

### Programmer View
![Programmer View](docs/screenshots/programmer.png)

### Connections View
![Connections View](docs/screenshots/connections.png)
