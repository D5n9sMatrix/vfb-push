# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.22

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/denis/vfb-net/vfb-push

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/denis/vfb-net/vfb-push/build

# Include any dependencies generated for this target.
include CMakeFiles/vfb-push.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include CMakeFiles/vfb-push.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/vfb-push.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/vfb-push.dir/flags.make

CMakeFiles/vfb-push.dir/vfb-push.cpp.o: CMakeFiles/vfb-push.dir/flags.make
CMakeFiles/vfb-push.dir/vfb-push.cpp.o: ../vfb-push.cpp
CMakeFiles/vfb-push.dir/vfb-push.cpp.o: CMakeFiles/vfb-push.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/denis/vfb-net/vfb-push/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/vfb-push.dir/vfb-push.cpp.o"
	/usr/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/vfb-push.dir/vfb-push.cpp.o -MF CMakeFiles/vfb-push.dir/vfb-push.cpp.o.d -o CMakeFiles/vfb-push.dir/vfb-push.cpp.o -c /home/denis/vfb-net/vfb-push/vfb-push.cpp

CMakeFiles/vfb-push.dir/vfb-push.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/vfb-push.dir/vfb-push.cpp.i"
	/usr/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/denis/vfb-net/vfb-push/vfb-push.cpp > CMakeFiles/vfb-push.dir/vfb-push.cpp.i

CMakeFiles/vfb-push.dir/vfb-push.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/vfb-push.dir/vfb-push.cpp.s"
	/usr/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/denis/vfb-net/vfb-push/vfb-push.cpp -o CMakeFiles/vfb-push.dir/vfb-push.cpp.s

# Object files for target vfb-push
vfb__push_OBJECTS = \
"CMakeFiles/vfb-push.dir/vfb-push.cpp.o"

# External object files for target vfb-push
vfb__push_EXTERNAL_OBJECTS =

libvfb-push.a: CMakeFiles/vfb-push.dir/vfb-push.cpp.o
libvfb-push.a: CMakeFiles/vfb-push.dir/build.make
libvfb-push.a: CMakeFiles/vfb-push.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/denis/vfb-net/vfb-push/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX static library libvfb-push.a"
	$(CMAKE_COMMAND) -P CMakeFiles/vfb-push.dir/cmake_clean_target.cmake
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/vfb-push.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/vfb-push.dir/build: libvfb-push.a
.PHONY : CMakeFiles/vfb-push.dir/build

CMakeFiles/vfb-push.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/vfb-push.dir/cmake_clean.cmake
.PHONY : CMakeFiles/vfb-push.dir/clean

CMakeFiles/vfb-push.dir/depend:
	cd /home/denis/vfb-net/vfb-push/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/denis/vfb-net/vfb-push /home/denis/vfb-net/vfb-push /home/denis/vfb-net/vfb-push/build /home/denis/vfb-net/vfb-push/build /home/denis/vfb-net/vfb-push/build/CMakeFiles/vfb-push.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/vfb-push.dir/depend
