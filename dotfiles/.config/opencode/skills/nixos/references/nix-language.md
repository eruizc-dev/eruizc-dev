# Nix Language Reference

## Data Types

```nix
# Strings
"hello world"
"interpolation: ${expr}"
''
  multi-line string
  with ${interpolation}
''

# Numbers
42        # integer
3.14      # float

# Booleans
true false

# Null
null

# Lists (whitespace-separated)
[ 1 "two" true ]

# Attribute sets
{ a = 1; b = 2; }
{ nested.attr = 42; }  # equivalent to { nested = { attr = 42; }; }

# Recursive sets (self-referencing)
rec { x = 1; y = x + 1; }
```

## Attribute Sets

```nix
# Access
attrset.a
attrset.a.b.c
attrset.a or "default"  # with default

# Merge (shallow, right takes precedence)
{ a = 1; } // { b = 2; }  # { a = 1; b = 2; }

# Check existence
attrset ? a  # true if 'a' exists

# Get names/values
builtins.attrNames { a = 1; b = 2; }  # [ "a" "b" ]
builtins.attrValues { a = 1; b = 2; }  # [ 1 2 ]
```

## Variable Binding

```nix
# let...in (local bindings)
let
  x = 1;
  y = x + 1;
in x + y  # 3

# with (bring attrs into scope)
with { a = 1; b = 2; }; a + b  # 3
with pkgs; [ git vim ]  # pkgs.git pkgs.vim

# inherit (copy from outer scope)
let x = 1; y = 2; in { inherit x y; }  # { x = 1; y = 2; }
{ inherit (pkgs) git vim; }  # { git = pkgs.git; vim = pkgs.vim; }
```

## Functions

```nix
# Single argument
x: x + 1
(x: x + 1) 5  # 6

# Multiple arguments (curried)
x: y: x + y
(x: y: x + y) 1 2  # 3

# Attribute set destructuring
{ a, b }: a + b
({ a, b }: a + b) { a = 1; b = 2; }  # 3

# With defaults
{ a, b ? 0 }: a + b

# Allow extra attributes
{ a, b, ... }: a + b

# Named pattern (access whole set)
args@{ a, b, ... }: a + b + args.c
{ a, b, ... }@args: a + b + args.c  # equivalent
```

## Control Flow

```nix
# if-then-else (expression, not statement)
if condition then "yes" else "no"

# assert
assert condition; expression

# throw/abort
throw "error message"
abort "fatal error"
```

## List Operations

```nix
# Concatenation
[ 1 2 ] ++ [ 3 4 ]  # [ 1 2 3 4 ]

# Common functions
builtins.length [ 1 2 3 ]  # 3
builtins.head [ 1 2 3 ]    # 1
builtins.tail [ 1 2 3 ]    # [ 2 3 ]
builtins.elemAt [ 1 2 3 ] 1  # 2 (0-indexed)
builtins.elem 2 [ 1 2 3 ]  # true

# map/filter
map (x: x * 2) [ 1 2 3 ]  # [ 2 4 6 ]
builtins.filter (x: x > 1) [ 1 2 3 ]  # [ 2 3 ]

# fold
builtins.foldl' (acc: x: acc + x) 0 [ 1 2 3 ]  # 6
```

## String Operations

```nix
# Concatenation
"hello" + " " + "world"

# Common functions
builtins.stringLength "hello"  # 5
builtins.substring 0 3 "hello"  # "hel"
builtins.replaceStrings ["a" "b"] ["x" "y"] "abc"  # "xyc"

# lib functions (need pkgs.lib)
lib.strings.toUpper "hello"  # "HELLO"
lib.strings.splitString "," "a,b,c"  # [ "a" "b" "c" ]
lib.concatStringsSep ", " [ "a" "b" ]  # "a, b"
```

## Paths and Files

```nix
# Paths (not strings!)
./relative/path
/absolute/path
./.  # current directory

# Path operations
./dir + "/file.nix"  # ./dir/file.nix
baseNameOf ./foo/bar.nix  # "bar.nix"
dirOf ./foo/bar.nix  # ./foo

# Read files
builtins.readFile ./file.txt
builtins.readDir ./dir  # { "file.txt" = "regular"; "subdir" = "directory"; }

# Import Nix files
import ./file.nix
import ./file.nix { inherit pkgs; }  # if file.nix is a function
```

## Fetchers

```nix
# Fetch URL
builtins.fetchurl {
  url = "https://example.com/file.tar.gz";
  sha256 = "...";
}

# Fetch tarball (auto-extracts)
builtins.fetchTarball {
  url = "https://github.com/owner/repo/archive/ref.tar.gz";
  sha256 = "...";
}

# Fetch git
builtins.fetchGit {
  url = "https://github.com/owner/repo";
  ref = "main";
  rev = "abc123...";
}
```

## Common lib Functions

```nix
# Attribute manipulation
lib.filterAttrs (n: v: v != null) { a = 1; b = null; }  # { a = 1; }
lib.mapAttrs (n: v: v + 1) { a = 1; b = 2; }  # { a = 2; b = 3; }
lib.recursiveUpdate { a.b = 1; } { a.c = 2; }  # { a = { b = 1; c = 2; }; }

# List utilities
lib.unique [ 1 2 1 3 ]  # [ 1 2 3 ]
lib.flatten [ 1 [ 2 [ 3 ] ] ]  # [ 1 2 3 ]
lib.optional true "x"  # [ "x" ]
lib.optional false "x"  # [ ]
lib.optionals true [ "x" "y" ]  # [ "x" "y" ]

# Conditionals
lib.optionalString true "yes"  # "yes"
lib.optionalAttrs true { a = 1; }  # { a = 1; }
```

## Debugging

```nix
# Print and return value
builtins.trace "debug message" expr

# Print value representation
builtins.trace (builtins.toJSON value) expr

# Deep sequence (force evaluation)
builtins.deepSeq expr result
```
