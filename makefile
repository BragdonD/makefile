DEBUG=yes

# Directory Settings
BUILD_DIR := bin
SRC_DIR := src
OBJ_DIR := obj
INC_DIR := inc
DEP_DIR := obj
DIRS := $(BUILD_DIR) $(SRC_DIR) $(OBJ_DIR) $(DEPS_DIR) $(INC_DIR)

CXX := g++
# -Walls : turn on  most of the information
# -g : turn on debug info
CXXFLAGS := -Wall -g
LDFLAGS := -I$(INC_DIR)

# Files loading
FILES := $(wildcard $(SRC_DIR)/*.cpp)
OBJECTS := $(FILES:src/%.cpp=obj/%.o)
INCLUDES := $(wildcard $(INC_DIR)/*.h)
DEPS := $(FILES:src/%.cpp=obj/%.d)
EXEC := main

all: $(BUILD_DIR)/$(EXEC)
	
$(BUILD_DIR)/$(EXEC) : $(OBJECTS) | $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -o $@ $^ $(LDFLAGS)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp $(INCLUDES) | $(OBJ_DIR)
	$(CXX) -c $(CXXFLAGS) $(LDFLAGS) $< -o $@
	$(CXX) -MM $(CXXFLAGS) $(LDFLAGS) $< > $(DEP_DIR)/$*.d

$(BUILD_DIR):
	@mkdir $(BUILD_DIR)

$(OBJ_DIR):
	@mkdir $(OBJ_DIR)
	
.PHONY: clean mrproper

clean:
	@rm -rf *.o

mrproper: clean
	@rm -rf $(EXEC)

# pull in dependency info for *existing* .o files
-include $(OBJECTS:.o=.d)