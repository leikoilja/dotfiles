# dotfiles

## Installation

Then bootstrap mise-managed tools, packages, and the rest of the dotfiles:

    cd ~/Development/dotfiles
    mise install
    mise bootstrap packages apply --manager brew
    mise bootstrap dotfiles apply

## Adding a new dependency

Don't `brew install` directly, it won't carry over to a fresh machine. Instead:

1. Check if mise has a native entry: `mise registry <name>`
2. If it prints a backend (`aqua:`, `asdf:`, `cargo:`, etc.), add it to `[tools]` in `mise.toml`, then run `mise install`.
3. If not (or the registry entry is broken, e.g. `btop`/`duckdb`), add it to `[bootstrap.packages]` as `"brew:<name>" = "latest"`, then run `mise bootstrap packages apply --manager brew`.
4. Commit the `mise.toml` change.