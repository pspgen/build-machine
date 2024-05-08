# build-machine image for building the images of pseudopotential generation tools

The image page is [here](https://hub.docker.com/r/pspgen/build-machine).

This is the base image for build the images of pseudopotential generation tool containers.

In the image, it installs and compiles the following tools:

- gfortran and gcc <= 7
- lapack and blas libraries ~3.10
- libxc ~= 4.3.4

The reason that we use these version is that pseudo generation codes are written in old fashion and usually not compatible with the latest version of compilers and libraries.

## How to build the image locally

First, clone the repository:

```bash
git clone https://github.com/pspgen/build-machine.git
```

Then, build the image:

```bash
cd build-machine
docker buildx bake -f docker-bake.hcl -f build.json --load
```

You'll see the image `pspgen/build-machine:newly-baked` in your local docker images by running `docker images`.

The versions of libraries and compilers are defined in the `build.json`.