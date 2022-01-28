# VSC-CPP-Basic-Config

This repository is a basic starting base for any C++ project which has a low to middle lvl of complexity.
It will allow you to start really fastly a new project with VSC.

## Basic C++ Makefile
This Makefile can be reused independantly of VSC
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

