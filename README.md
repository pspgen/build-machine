# psp-prerequisites

This is the base image for build the images of pseudopotential generation tool containers.

In the image, it installs and compiles the following tools:

- gfortran and gcc <= 7
- lapack and blas libraries ~3.10
- libxc ~= 4.3.4

The reason that we use these version is that pseudo generation codes are written in old fashion and usually not compatible with the latest version of compilers and libraries.