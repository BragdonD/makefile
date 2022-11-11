# Makefile For C++ or C project

## Presentation

### French 🇫🇷 

Dans ce dépot vous pourrez trouver des `makefiles` pour compiler vos projets codés en `c++` ou en `c` et de toutes tailles. Les makefiles sont à inclure dans le `dossier root` du projet. Afin de lancer le makefile vous pouvez utiliser la commande `mingw32-make`.

Comme dit plus haut il y a différents makefiles, il y a le makefile pour les petits et moyen projets, il est très utiles pour des projets n'incluant pas de sous-dossier dans les dossiers sources.

Enfin il y a le makefile pour des projets de grande taille qui permet d'avoir des sous-dossiers.


### English 🇬🇧 

In this repository you can find makefiles to compile your projects coded in c++ or in c and of all sizes. The makefiles are to be included in the base folder of the project. In order to run the makefile you can use the command mingw32-make.

As said above there are different makefiles, there is the makefile for small and medium projects, it is very useful for projects that do not include a subfolder in the source folders.

Finally there is the makefile for large projects which allows to have subfolders.

## Organisation du projet

- src       | - *.cpp ou *.c
- inc       | - *.hpp ou *.h
- inc\bits  | - *.tcc
- bin       | - *.exe
- obj       | - *.o et *.d

Cette organisation peut être modifiée en changeant les nom des dossiers dans le makefile. Attention la path des dependances et des objets doit rester la même sinon il faudra changer la manière de récupérer les dépendances égalements.

## Flags to add to CXXFLAGS
### Search and Link flags
- `-l[lib_name]`: link a library to the program. Example: -lws2_32 to link the socket library under windows.
- `-L[path_to_lib]`: search for additional lib into this path.
- `-I[path_to_inc]`: search for additional include.
- `-D[flag]`: pass preprocessor flag. Can add define to the code.
### GCC and GDB
#### STD Version
- `-std=c++[version]`: fix the c++ version to use. (Same for C and gnu).
#### Verbosity / Debug
- `-Wall`: Turn on most of compiler warning flags.
- `-Werror`: Turn all compiler warning into error.
- `-W`: Turn all the flags not enabled by -Wall.
- `-pedantic`: Issue warning relative to ISO norms.
#### Optimization
- `-O0`: no optimization.
- `-O2` mid level of optimization.
- `-O3`: higher level of optimization.
- `-OFast`: higher than -O3.
- `-m32`: code for 32-bit environment.
- `-m64`: code for 64-bit environment.
- `-finline-functions`: integrate simple function(up to the compiler to decide) into their callers.
#### Special Options
- `-g`: for debug purpose to use gdb. Need to be remove in deploy app.
- `-pie`: builds a dynamically linked position independant exe.
- `-static-pie`: builds a statically linked position independant exe.
- `-shared`: build a shared lib (*.so file for unix, *.dll for windows).
- `-fno-exceptions`: remove c++ exceptions.
- `-fno-rtti`: remove run time informations

## Run the project
After running the makefile you can run the following command to run your project : `.\bin\main`
WARNING: `main` is just the name given to the output program if you rename it then the command change too.

## Reminder
Since a makefile is not the same as an IDE you need to save the files yourself!!!!!

## Resolve some bugs
Recently when running those makefile i come with the follow errors :
```
mkdir obj
process_begin: CreateProcess(NULL, mkdir obj, ...) failed.
make (e=2): The system cannot find the file specified.
make: *** [makefile:45 obj] Error 2
```
So the source of the problem was coming from my compiler which is the MINGW project from MSYS. Inside this project the command mkdir is not present. I don't know why it was working before...
Anyways to fix it you need to download the directory from this link : https://sourceforge.net/projects/unxutils/?source=typ_redirect and then you extract the tools necessary inside the `bin` directory of your compiler.

## Bibliographie

- https://stackoverflow.com/questions/2483182/recursive-wildcards-in-gnu-make
- https://www.gnu.org/software/make/manual/html_node/File-Name-Functions.html
