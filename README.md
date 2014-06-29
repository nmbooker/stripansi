# stripansi

Strips ANSI escape sequences out of a stream of characters

## Usage

Assuming 'dirty' is a program that insists on spitting out ANSI escape
characters even in pipelines.

```
$ dirty | ./stripansi > cleaned_up_output.txt
```

## Compiling

### Install Glasgow Haskell Compiler and Make

You need 'ghc' and 'make' installed.

```
$ sudo apt-get install ghc make
```

If you find it's missing libraries, you might have to go the whole
hog and install the haskell-platform:

```
$ sudo apt-get install haskell-platform make
```

### Make it

```
$ make clean all
```

If developing, just run `make` to save compiling dependencies every time.

## Limitations

This currently only deals with the most common ones output by
Unix programs that want to colour their output on screen, namely the
`ESC <blah> m` sequences

However it should be quite easy to extend to other types - you just
need to modify the following pattern to match any of a set of letters
rather than just 'm':

```
rescs    ('m':xs)         True             = rescs xs False
```

Also if your platform uses something other than ESC to begin the
escape sequences, change the following line to suit:

```
rescs    ('\x1b':xs)      False            = rescs xs True
```

# Bugs

If you find a bug, or you really want another escape sequence other than
those already supported to be stripped (e.g. `ESC <blah> C`) please
file a bug in

  https://github.com/nmbooker/stripansi/issues

# Copyright

```
Strip terminal ANSI colour sequences out of input.

Copyright (C) 2013-2014     Nicholas Martin Booker <NMBooker@gmail.com>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
```
