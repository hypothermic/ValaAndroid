# additional target to perform clang-format run, requires clang-format

# get all project files
function(use_format)
	find_program(CLANG_FORMAT clang-format)
	file(GLOB_RECURSE ALL_SOURCE_FILES *.c *.h)
	add_custom_target(
		    clangformat
		    COMMAND ${CLANG_FORMAT}
		    -style=file
		    -i
		    ${ALL_SOURCE_FILES}
	)
endfunction()

use_format()
