# Directory Settings
BUILD_DIR 		:= bin
SRC_DIR 		:= src
OBJ_DIR 		:= obj
INC_DIR 		:= inc
DEP_DIR 		:= obj

#EXTENSION
SRC_EXT 		:= c
INC_EXT 		:= h
OBJ_EXT 		:= o
DEP_EXT 		:= d

#COMPILER SETTINGS
CXX 		:= gcc	
CXXFLAGS 	:= -Wall -g # -g is for debugging
LDFLAGS 	:= -I$(INC_DIR) #Add your lib include and compiler flag here

#recursive wildcard
rwildcard = $(foreach d,$(wildcard $(1:=/*)),$(call rwildcard,$d,$2) $(filter $(subst *,%,$2),$d))

# Files loading
FILES 		:= $(call rwildcard,$(SRC_DIR), *.$(SRC_EXT))	
SUB_SRC_DIR := $(sort $(dir $(wildcard $(SRC_DIR)/*/)))
STRIP_FILES	:= $(notdir $(FILES))
OBJECTS 	:= $(STRIP_FILES:%.$(SRC_EXT)=$(OBJ_DIR)/%.$(OBJ_EXT))	
INCLUDES 	:= $(call rwildcard, $(INC_DIR), *.$(INC_EXT))	
DEPS 		:= $(STRIP_FILES:%.$(SRC_EXT)=$(OBJ_DIR)/%.$(OBJ_EXT))		
EXEC 		:= main			

vpath %.$(SRC_EXT) $(SUB_SRC_DIR)

# build all the object and dependancies files from the *.cpp files
$(OBJ_DIR)/%.$(OBJ_EXT): %.$(SRC_EXT) $(INCLUDES) | $(OBJ_DIR)
	$(CXX) -c $(CXXFLAGS) $(LDFLAGS) $< -o $@
	$(CXX) -MM $(CXXFLAGS) $(LDFLAGS) $< > $(DEP_DIR)/$*.$(DEP_EXT)

# main execution
all: $(BUILD_DIR)/$(EXEC)

# build the executable by linking the object and creating the bin directory if not already created
$(BUILD_DIR)/$(EXEC) : $(OBJECTS) | $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -o $@ $^ $(LDFLAGS)

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

