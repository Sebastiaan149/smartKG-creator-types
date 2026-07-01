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

-S: This parameter enables the selection of only those families that have a minimum percentage of subjects present in the dataset. This option is particularly useful for unstructured datasets like Dbpedia. By default, the minimum percentage is set to αs = 0.01. To modify this value, users need to invoke the "-P" parameter.

-P: This parameter allows users to set the minimum percentage of subjects required for a family to be selected. This parameter can only be used in conjunction with the "-S" parameter. If the "-S" parameter is enabled and "-P" is not specified, the default value of 0.01 is used. The value specified for this parameter denotes αs in equation (23).

-L <percentage>: This parameter allows users to specify the percentage of infrequent predicates in terms of their occurrences within the dataset. Predicates that have less than the specified percentage of occurrences (as a percentage of the total number of triples) will be discarded and not considered in the families. The default value of this parameter is 0.01%. The value specified for this parameter corresponds to τplow in equation (21).

-H <percentage>: This parameter allows users to specify the percentage of occurrences at which massive predicates are to be cut, expressed as a percentage of the total number of triples. Predicates that have more than the specified percentage of occurrences will be discarded. The default value of this parameter is 0.1%. The value specified for this parameter corresponds to τphigh in equation (21).

-m <Percentage>: This parameter enables users to specify the maximum size of a new group in terms of a percentage of the total number of triples. For instance, if the parameter is set to 5, a new group is created only if the estimated size is less than 5% of the total number of triples. If "-m" is set to 100, then all groups are allowed. The value of this parameter corresponds to αt in equation (24).

-q: activate quick estimation (do not perform grouping)

# Generate families

./hdt-cpp-molecules/libhdt/tools/getFamilies dataset.hdt

## Generation Parameters

-s prefix: Prefix for the splitted families (e.g. part_watdiv.10M_). Mandatory
-e <exportFile>: This argument exports the metadata of families in <exportFile>.json and the groups in <exportFile>_group.json. This information can be used by the query planner to locate the HDT partition containing the results of a given query.
-S : Activate the option to get only families with a presence of a minimum % of subjects. Recommended for very unstructured datasets (e.g. Dbpedia).
-P <percentage>: set up the % of subjects to limit families with a minimum of the given <percentage>. It requires to activate the -S option. If -S is activate and -P is not specified, the default value is 0.01
-L <percentage>: Setup the percentage for infrequent predicates in % occurrences (the more, the less partitions). Predicates with less % occurrences (over the total number of triples) than the given percentage will be discarded and not considered in the families. The default value is 0.01%.
-H <percentage>: Setup the percentage to cut massive predicates in % occurrences (the more, the more partitions). Predicates with more % ocurrences (over the total number of triples) than the given percentage will be discarded. The default value is 0.1%. 
-i: This argument includes infrequent predicates with occurrences less than the user-defined threshold τl (default 0.01%), which may result in the creation of more partitions. This argument is set to false by default.
-C <classesFile>: this argument accepts a file containing a list of classes separated by a new line. The typed-family partition is applied only to the classes listed in this file. This argument is used only to perform typed-family partitioning as defined in the paper.
-d: This argument dumps infrequent predicates into a dedicated JSON file with the prefix "_infreqPreds". Infrequent predicates are defined by Equation (21).
-u: ungroup – This argument performs family partitioning without the grouping step, which generates partitions based solely on the original families defined in Equations (7) and (8).
-G: This argument exports each family into a separate JSON file.
-v: This argument enables verbose mode, providing detailed results by printing all triples during partitioning. We recommend using this argument only for testing purposes.
-h: This argument provides a verbose explanation of the available arguments.


Example for TYPED-FAMILY partitioning using classes.txt file:

1. Generate classes file:
./make_filtered_classes.sh data/dataset.nt 0.001 20 classes.txt

2. Partitioning using the classes file:

./hdt-cpp-molecules/libhdt/tools/getFamilies dataset.hdt -e metadata -C classes.txt

OR (from data folder):
../../smartKG-creator-types/libhdt/tools/getFamilies ../dataset.hdt -e metadata -C ../classes.txt 


# Convert NT to HDT files (necessary for partitioning transfer):

(from data nt folder):
.convertToHDT.sh <destinationFolderName>