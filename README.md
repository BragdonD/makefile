# VSC-CPP-Basic-Config
This repository is a starting base for any C++ project which has a low to middle lvl of complexity.
It will allows you to start really fast a new project with VSC.
## Project's tree
To init the project you need to create a src directory where you will put every source file with the `.cpp` extension.
```tree
-- .vscode
	|- task.json
	|- launch.json
	|- c_cpp_properties.json
-- src
	|- *.cpp
-- inc
	|- *.h
	|- *.hpp
```
# Run the project
To compile the project you will need to used the task in the task.json `compile C++ project`.
```json
{
	"type": "shell",
	"label": "compile C++ project",
	"command": "",
	"args": [
		"mingw32-make"
	],
	"problemMatcher": [
		"$msCompile",
	],
	"presentation": {
		"echo": true,
		"reveal": "always",
		"focus": false,
		"panel": "shared",
		"showReuseMessage": true,
		"clear": false
	},
	"group": {
		"kind": "build",
		"isDefault": true
	},
	"detail": "compilateur: path_of_your_compiler"
},
```
To use this task, you will need to be onto the `makefile`.
Next, you will want to run the program you just created. You have two options:
- Run the project standardly
- Run the project in debug mode
### Run the project standardly
If you wanna use this option. You will need to use this task :
```json
{
   	"type": "shell",
    	"label": "C++ run",
	"command": "${workspaceFolder}\\bin\\main.exe",
	"args": [],
    	"group": {
		"kind": "build",
		"isDefault": true
	}
 }
```
And tada your program is running. 
### Run the project in debug mode
If you wanna use this option. You will need the `launch.json` file.
```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "(gdb) Lancer",
            "type": "cppdbg",
            "request": "launch",
            "program": "${workspaceFolder}\\bin\\main.exe",
            "args": [],
            "stopAtEntry": false,
            "cwd": "${fileDirname}",
            "environment": [],
            "externalConsole": false,
            "MIMode": "gdb",
            "miDebuggerPath": "path_to_your_gdb",
            "setupCommands": [
                {
                    "description": "Activer l'impression en mode Pretty pour gdb",
                    "text": "-enable-pretty-printing",
                    "ignoreFailures": true
                }
            ]
        }
    ]
}
```
Then, you will need to execute the debug mode with the `F5` key.
## Basic C++ Makefile
This Makefile can be reused independantly of VSC.
```makefile
# Directory Settings
BUILD_DIR := bin
SRC_DIR := src
OBJ_DIR := obj
INC_DIR := inc
DEP_DIR := obj

CXX := g++ #compilator flag
# -Wall : turn on  most of the information
# -g : turn on debug info
# -ansi : turn on verbose
# -pedantic : complete -ansi tag
CXXFLAGS := -Wall -g -ansi -pedantic
LDFLAGS := -I$(INC_DIR)

# Files loading
FILES := $(wildcard $(SRC_DIR)/*.cpp) # load all the *.cpp files
OBJECTS := $(FILES:src/%.cpp=obj/%.o) # convert all the *.cpp into .o object inside the ./obj/ directory
INCLUDES := $(wildcard $(INC_DIR)/*.h) # load all the header files
DEPS := $(FILES:src/%.cpp=obj/%.d) # convert all the *.cpp into .d dependancies inside the ./obj/ directory
EXEC := main # name of the executable generated

# main execution
all: $(BUILD_DIR)/$(EXEC)
	
# build the executable by linking the object and creating the bin directory if not already created
$(BUILD_DIR)/$(EXEC) : $(OBJECTS) | $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -o $@ $^ $(LDFLAGS)

# build all the object and dependancies files from the *.cpp files
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp $(INCLUDES) | $(OBJ_DIR)
	$(CXX) -c $(CXXFLAGS) $(LDFLAGS) $< -o $@
	$(CXX) -MM $(CXXFLAGS) $(LDFLAGS) $< > $(DEP_DIR)/$*.d

# create the directory build
$(BUILD_DIR):
	@mkdir $(BUILD_DIR)

# create the object build
$(OBJ_DIR):
	@mkdir $(OBJ_DIR)

# clean all the project
.PHONY: clean mrproper

clean:
	@rm -rf *.o

mrproper: clean
	@rm -rf $(EXEC)

# pull in dependency info for *existing* .o files
-include $(OBJECTS:.o=.d)
```
