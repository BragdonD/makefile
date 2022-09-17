# Directory Settings
BUILD_DIR := bin
SRC_DIR := src
OBJ_DIR := obj
INC_DIR := inc
DEP_DIR := obj

#EXTENSION
SRC_EXT 		:= c
INC_EXT 		:= h
OBJ_EXT 		:= o
DEP_EXT 		:= d

CXX := gcc		#compilator flag
# -Wall : turn on  most of the information
# -g : turn on debug info
# -ansi : turn on verbose
# -pedantic : complete -ansi tag
CXXFLAGS := -Wall -g -ansi -pedantic
LDFLAGS := -I$(INC_DIR)

# Files loading
FILES := $(wildcard $(SRC_DIR)/*.cpp)	# load all the *.cpp files
OBJECTS := $(FILES:$(SRC_DIR)/%.$(SRC_EXT)=$(OBJ_DIR)/%.$(OBJ_EXT))	# convert all the *.cpp into .o object inside the ./obj/ directory
INCLUDES := $(wildcard $(INC_DIR)/*.$(INC_EXT))	# load all the header files
DEPS := $(FILES:%.$(SRC_EXT)=$(OBJ_DIR)/%.$(OBJ_EXT))	# convert all the *.cpp into .d dependancies inside the ./obj/ directory
EXEC := main							# name of the executable generated

# main execution
all: $(BUILD_DIR)/$(EXEC)
	
# build the executable by linking the object and creating the bin directory if not already created
$(BUILD_DIR)/$(EXEC) : $(OBJECTS) | $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -o $@ $^ $(LDFLAGS)

# build all the object and dependancies files from the *.cpp files
$(OBJ_DIR)/%.$(OBJ_EXT): %.$(SRC_EXT) $(INCLUDES) | $(OBJ_DIR)
	$(CXX) -c $(CXXFLAGS) $(LDFLAGS) $< -o $@
	$(CXX) -MM $(CXXFLAGS) $(LDFLAGS) $< > $(DEP_DIR)/$*.$(DEP_EXT)

# create the directory build
$(BUILD_DIR):
	@mkdir $(BUILD_DIR)

# create the object build
$(OBJ_DIR):
	@mkdir $(OBJ_DIR)

# clean all the project
.PHONY: clean mrproper

clean:
	@rm -rf *.$(OBJ_EXT)

mrproper: clean
	@rm -rf $(EXEC)

# pull in dependency info for *existing* .o files
-include $(OBJECTS:.$(OBJ_EXT)=.$(DEP_EXT))
