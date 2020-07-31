# axel docker

Pretty simple. Build the container, tag as you wish. `axel` will be in $PATH and `man axel` will work. This repo uses a submodule, so be sure to clone recursively or `git submodule init && git submodule update` before building. This repo will use [axel 2.17.9](https://github.com/axel-download-accelerator/axel/tree/v2.17.9) but feel free to pull/checkout whatever version you like.

It should go without saying you'll need to mount a volume/bind to write your downloads into. Some suggested command lines:

    podman build --tag axel .
    podman run --rm -it --mount "type=bind,src=/tmp,target=/mnt/tmp" axel
    # cd to /mnt/tmp and commence downloads!

