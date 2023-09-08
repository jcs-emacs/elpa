indent-bars highlights indentation with configurable font-lock
based vertical bars, using stipples.  The color and appearance
(weight, pattern, position within the character, zigzag, etc.) are
all configurable.  Includes the option for depth-varying colors and
highlighting the indentation level of the current line.  Bars span
blank lines, by default.  Optionally uses tree-sitter to fine-tune
indentation depth.  indent-bars works in any mode using fixed tab
or space-based indentation.  In the terminal (or on request) it
uses vertical bar characters instead of stipple patterns.
