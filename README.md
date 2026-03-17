# Setup

Install the necessary dependencies:

- [GNU Autoconf](https://www.gnu.org/software/autoconf/autoconf.html)

  - `sudo apt install autoconf` on Debian-based distros (e.g., Ubuntu)
  - `sudo dnf install autoconf` on Red Hat-based distros (e.g.,
    Fedora)

- [GNU Libtool](https://www.gnu.org/software/libtool/)

  - `sudo apt install libtool` on Debian-based distros (e.g., Ubuntu)
  - `sudo dnf install libtool` on Red Hat-based distros (e.g., Fedora)

- [GNU zip (gzip)](http://www.zlib.net/) Allows GNU zipped RDF input
  files to be ingested, and allows GNU zipped HDT files to be loaded.

  - `sudo apt install gzip` on Debian-based distros (e.g., Ubuntu)
  - `sudo dnf install gzip` on Red Hat-based distros (e.g., Fedora)

- [pkg-config](https://www.freedesktop.org/wiki/Software/pkg-config/)
  A helper tool for compiling applications and libraries.

  - `sudo apt install pkg-config` on Debian-based distros (e.g.,
    Ubuntu)
  - `sudo dnf install pkgconf-pkg-config` on Red Hat-based distros
    (e.g., Fedora)

- [Serd v0.28+](https://github.com/drobilla/serd) The default parser
  that is used to process RDF input files.  It supports the N-Quads,
  N-Triples, TriG, and Turtle serialization formats.

  - `sudo apt install libserd-0-0 libserd-dev` on Debian-based distros
    (e.g., Ubuntu)
  - `sudo dnf install serd serd-devel` on Red Hat-based distros (e.g.,
    Fedora)

- [GNU Lib]
  - `sudo apt install gnulib` on Debian-based distros (e.g., Ubuntu)


# Compilation

To compile, go inside the root folder and execute following commands in order:

```
./gnulib.sh
./autogen.sh
./configure
make -j4
```

# Show statistics 

./hdt-cpp-molecules/libhdt/tools/getFamiliesEstimate dataset.hdt

## Statistics Parameters

-S : Activate the option to get only families with a presence of a minimum % of subjects. Recommended for very unstructured datasets (e.g. Dbpedia).
-P <percentage>: set up the % of subjects to limit families with a minimum of the given <percentage>. It requires to activate the -S option. If -S is activate and -P is not specified, the default value is 0.01
-L <percentage>: Setup the percentage for infrequent predicates in % occurrences (the more, the less partitions). Predicates with less % occurrences (over the total number of triples) than the given percentage will be discarded and not considered in the families. The default value is 0.01%.
-H <percentage>: Setup the percentage to cut massive predicates in % occurrences (the more, the more partitions). Predicates with more % ocurrences (over the total number of triples) than the given percentage will be discarded. The default value is 0.1%. 
-q: Activate quick estimation (do not perform grouping)

# Generate families

./hdt-cpp-molecules/libhdt/tools/getFamilies dataset.hdt

## Generation Parameters

-s prefix: Prefix for the splitted families (e.g. part_watdiv.10M_). Mandatory
-e <exportFile.json> Export metadata of families in <exportFile>.json
-S : Activate the option to get only families with a presence of a minimum % of subjects. Recommended for very unstructured datasets (e.g. Dbpedia).
-P <percentage>: set up the % of subjects to limit families with a minimum of the given <percentage>. It requires to activate the -S option. If -S is activate and -P is not specified, the default value is 0.01
-L <percentage>: Setup the percentage for infrequent predicates in % occurrences (the more, the less partitions). Predicates with less % occurrences (over the total number of triples) than the given percentage will be discarded and not considered in the families. The default value is 0.01%.
-H <percentage>: Setup the percentage to cut massive predicates in % occurrences (the more, the more partitions). Predicates with more % ocurrences (over the total number of triples) than the given percentage will be discarded. The default value is 0.1%. 
-i Include infrequent predicates (they are not included by default).

