这是一个演示了cmake和最简单mongoose库的例子,假定的编程语言是C。这个库可以做为mongoose应用程序的起点，当然也可以做为其他c语言应用开发的框架，当然可以用来学习cmake。其基本目录为src源代码，dist第三方库，htdocs存放web资源。主脚本是build.sh，使用方法如下:    
This is an example demonstrating cmake and the simplest [mongoose](https://mongoose.ws/ ) library, assuming the programming language is C. This library can serve as a starting point for mongoose applications, as well as a framework for developing other C language applications and learning cmake. Its basic directory consists of src source code, dist third-party libraries, and htdocs for storing web resources. The main script is build.sh, and the usage method is as follows:
    Build options:
      installdeps:      installs build and runtime dependencies"    
      release:          build release files in directory release (stripped)"   
      install:          installs release files from directory release"
                        following environment variables are respected"
                          - DESTDIR=\"\""
      uninstall:        removes myapp files, leaves configuration and "
                        state files in place"
                        following environment variables are respected"
                          - DESTDIR=\"\""    