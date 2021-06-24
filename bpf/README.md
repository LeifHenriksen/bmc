https://github.com/Orange-OpenSource/bmc-cache

BMC
===

BMC (BPF Memory Cache) is an in-kernel cache for memcached. It enables runtime, crash-safe extension of the Linux kernel to process specific memcached requests before the execution of the standard network stack. BMC does not require modification of neither the Linux kernel nor the memcached application. Running memcached with BMC improves throughput by up to 18x compared to the vanilla memcached application.

Requirements
---

Linux kernel __v5.3__ or higher is required to run BMC.

Other software dependencies are required to build BMC and Memcached-SR (see [Building BMC](#building-bmc) and [Building Memcached-SR](#building-memcached-sr)). 

Build instructions
---

### Building BMC

BMC must be compiled with libbpf and other header files obtained from kernel sources. The project does not include the kernel sources, but the [kernel-src-download.sh](kernel-src-download.sh) and [kernel-src-prepare.sh](kernel-src-prepare.sh) scripts automate the download of the kernel sources and prepare them for the compilation of BMC.

These scripts require the following software to be installed:

```sh
gpg curl tar xz make gcc flex bison libssl-dev libelf-dev
```

The project uses llvm and clang version 9 to build BMC, but more recent versions might work as well:

```sh
llvm-9 clang-9
```

Note that ```libelf-dev``` is also required to build libbpf and BMC.

With the previous software installed, BMC can be built with the following:
```bash
$ ./kernel-src-download.sh
$ ./kernel-src-prepare.sh
$ cd bmc && make
```

After BMC has been successfully built, kernel sources can be removed by running the [kernel-src-remove.sh](kernel-src-remove.sh) script from the project root.

### Building Memcached-SR

Memcached-SR is based on memcached v1.5.19. Building it requires the following software:

```sh
clang-9 (or gcc-9) automake libevent-dev
```

Either ```clang-9``` or ```gcc-9``` is required in order to compile memcached without linking issues. Depending on your distribution, you might also need to use the ```-Wno-deprecated-declarations``` compilation flag.

Memcached-SR can be built with the following:
```bash
$ cd memcached-sr 
$ ./autogen.sh
$ CC=clang-9 CFLAGS='-DREUSEPORT_OPT=1 -Wno-deprecated-declarations' ./configure && make
```

The ```memcached``` binary will be located in the memcached-sr directory.


License
---

Files under the [bmc](bmc) directory are licensed under the [GNU Lesser General Public License version 2.1](LICENSE) license.

Files under the [memcached-sr](memcached-sr) directory are licensed under the [BSD-3-Clause BSD](LICENSE&#32;(Memcached&#32;customizations)) license.
