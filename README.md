# Freebasic compiler

Freebasic docker image for BUT-FIT IFJ17 project.

Including:

- All needed libraries
- gcc
- make
- valgrind
- Criterion framework (for c unit tests)
- zip / bzip2 / unzip
- ic17int interpreter

Cannot base image from Alpine linux. ==> Investigate why and try to update. <br />
Final CMD could be something else, in this stage of development is tail acceptable.
