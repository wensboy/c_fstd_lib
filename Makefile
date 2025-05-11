# 指定编译器(compiler)
CC = clang
# 头文件路径(include scan path)
INCLUDE = -Iinclude -Iinclude/type -Iinclude/SDL3
# 编译参数(compile options)
CFLAGS = -Wall -Wextra -g $(INCLUDE)
# 库文件路径(lib path)
LIB_DIR = $(shell find ./lib -type d)
LIB = $(addprefix -L,$(LIB_DIR))
# 链接器(ld)
LDFLAGS = $(LIB)

# 源文件目录(src file dir)
SRC_DIR = src
# 构建目录(build dir)
BUILD = build
# 可执行文件目录(exe dir)
BIN = bin
# 测试目录(test dir)
TEST_DIR = test
# 目标文件(target file)
TARGET = c_lib
# 测试目标文件(test target file)
TEST_TARGET = c_lib_test
# 源文件(src files)
SRCS = $(wildcard $(SRC_DIR)/*/*.c)
# 测试文件(test files)
TEST_FILE = test_type.c
TEST = $(TEST_DIR)/$(TEST_FILE)
# 中间文件(obj files)
OBJS = $(patsubst %.c,$(BUILD)/%.o,$(SRCS))
# 测试中间文件(test obj files)
TEST_OBJ = $(patsubst %.c,$(BUILD)/%.o,$(TEST))

# 默认规则
all: $(BIN)/$(TARGET)

# 可执行文件构建 
$(BIN)/$(TARGET): $(OBJS)
	@mkdir -p $(BIN)
	$(CC) $(CFLAGS) $^ -o $@ $(LDFLAGS)

# 测试二进制文件构建
$(BIN)/$(TEST_TARGET): $(OBJS) $(TEST_OBJ)
	@mkdir -p $(BIN)
	$(CC) $(CFLAGS) $^ -o $@ $(LDFLAGS)

$(BUILD)/%.o: %.c
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

test: $(BIN)/$(TEST_TARGET)

clean:
	rm -rf $(BIN) $(BUILD)

.PHONY: all clean test
