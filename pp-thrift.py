#!/usr/bin/env python3

import sys
import re


def pretty_print_struct_string(struct_string):
    """
    Parses and pretty-prints a string representation of a nested data struct.

    This function is designed to format strings that look like Python object
    representations, e.g., 'ClassName(field1=value1, field2=...)'.
    """
    indent_char = "  "  # Use 2 spaces for indentation
    current_indent = 0
    result = []
    in_string_literal = False

    # Pre-process to handle tricky parts and ensure consistency
    # 1. Add quotes around unquoted values like TCCZXOS1B, BUYER, etc.
    #    This uses a negative lookbehind to avoid changing numbers, True/False, or already quoted strings.
    #    It specifically looks for a colon or equals sign, followed by a value that isn't a nested object.
    processed_string = re.sub(r'(:|=)\s*([a-zA-Z_][a-zA-Z0-9_\-.]+)(?=[,\)])', r'\1"\2"', struct_string)
    # 2. Treat the special <...> syntax as a string
    processed_string = re.sub(r'(<[^>]+>)', r"'\1'", processed_string)

    for char in processed_string:
        if char in '({[':
            # Increase indent and add a newline after the opening character
            result.append(char)
            result.append('\n')
            current_indent += 1
            result.append(indent_char * current_indent)
        elif char in ')}]':
            # Decrease indent and add a newline before the closing character
            result.append('\n')
            current_indent -= 1
            result.append(indent_char * current_indent)
            result.append(char)
        elif char == ',':
            # Add a newline and indent after a comma
            result.append(char)
            result.append('\n')
            result.append(indent_char * current_indent)
        elif char == '"':
            in_string_literal = not in_string_literal
            result.append(char)
        elif char.isspace() and in_string_literal:
            # Preserve spaces within string literals
            result.append(char)
        elif not char.isspace():
            # Add any other non-whitespace character
            result.append(char)

    print("".join(result))


struct = ''.join(sys.stdin)
pretty_print_struct_string(struct)
