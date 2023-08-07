Module-Info Version
==========

Checks if `module-info.class` contains the precise JDK version or not, which makes Reproducible Build harder because the exact minor JDK release is required.

Result
-----

- when using `javac --release <r>` **with `<r>` not equals to major JDK version**, no version is stored.
- but without `--release` or with `--release <JDK major version>`, the detailed JDK version is stored in `module-info.class`

Run
---

Tested with JDK 11 to JDK 21 EA, for example with 21 EA:

```
$ ./run.sh
openjdk 21-ea 2023-09-19
OpenJDK Runtime Environment (build 21-ea+31-2444)
OpenJDK 64-Bit Server VM (build 21-ea+31-2444, mixed mode, sharing)
'javac'
  1                                       // requires
    #8,8000                                 // "java.base" ACC_MANDATED
    #10                                     // 21-ea
'javac --release 21'
  1                                       // requires
    #8,8000                                 // "java.base" ACC_MANDATED
    #10                                     // 21-ea
'javac --release 20'
  1                                       // requires
    #8,8000                                 // "java.base" ACC_MANDATED
    #0
'javac --release 19'
  1                                       // requires
    #8,8000                                 // "java.base" ACC_MANDATED
    #0

```

Tracking
--------

- Maven: [MJAR-295](https://issues.apache.org/jira/browse/MJAR-295)
- JDK: issue to be opened
