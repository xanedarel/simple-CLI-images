# Simple CLI Images
A simple BASH utility for browsing and displaying image files in directly in a CLI or using other software. 

This is very early code, please forgive any mistakes and don't hesitate to contact me.

## Features
- Autocompletion for file names
- Display images directly into the terminal
- Open images using other software
- Select a random image among a folder


## Needed Software
You will need :
```bash
#rlwrap for autocompletion and file selection
apt install rlwrap
```

## Additional Software
For SCI to work with its full potential you may need :
> Feh and xdg-open :
```
apt install feh xdg-utils
```
> [Viu](https://github.com/atanunq/viu) (to display images in the terminal) which can be found here and installed as follows :
- Setup a local [Rust environment](https://www.rust-lang.org/tools/install) : 
```
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```
- Install build-essential (to fix an error when installing viu)
```
apt install build-essential
```
- Finally install viu
```
cargo install viu
```

You now have all the needed software!


## Addendum
Many thanks to Atanunq and their software which made SCI possible.
