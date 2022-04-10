# Mizer

<img src="assets/logo@512.png" width="256px" />

A node based visualization tool for live scenarios (e.g. concerts and clubs).

![Nodes View](docs/screenshots/nodes.png)

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

### 2D Plan View
![2D Plan View](docs/screenshots/plan.png)

### Nodes View
![Nodes View](docs/screenshots/nodes.png)

### Sequencer View
![Sequencer Cue List](docs/screenshots/sequencer_cue_list.png)
![Sequencer Track Sheet](docs/screenshots/sequencer_track_sheet.png)

### Programmer View
![Programmer View](docs/screenshots/programmer.png)

### Presets View
![Presets View](docs/screenshots/presets.png)

### Connections View
![Connections View](docs/screenshots/connections.png)

### Fixture Patch
![Fixture Patch](docs/screenshots/patch.png)
