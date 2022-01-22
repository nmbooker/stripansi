# stripansi

Strips ANSI escape sequences out of a stream of characters

## Usage

Assuming 'dirty' is a program that insists on spitting out ANSI escape
characters even in pipelines.

```
$ dirty | stripansi > cleaned_up_output.txt
```

## Compiling

### Install Glasgow Haskell Compiler and cabal-install

You need 'ghc' and 'cabal-install' installed

```
$ sudo apt-get install ghc cabal-install
```

If you find it's missing libraries, you might have to go the whole
hog and install the haskell-platform:

```
$ sudo apt-get install haskell-platform cabal-install
```

### Make it

```
$ cabal v2-build
```

Watch the output to see where cabal put the compiled executable

## Limitations

The worst limitation is that stripansi assumes that any instance of the
ESC character in your input text is the start of a colour command.
Therefore if you have a spurious ESC character and no 'm' later, the rest
of your text will be thrown away.

This currently only deals with the most common ones output by
Unix programs that want to colour their output on screen, namely the
`ESC <blah> m` sequences

However it should be quite easy to extend to other types - you can
add patterns to drop other terminating letters and switch back to
InText state.

```
stateMachine InANSICode ('d':xs) =
    stateMachine InText xs
```

Also if your platform uses something other than ESC to begin the
escape sequences, change the following line to suit:

```
stateMachine InText ('\x1b':xs) =
    stateMachine InANSICode xs
```

# Bugs

If you find a bug, or you really want another escape sequence other than
those already supported to be stripped (e.g. `ESC <blah> C`) please
file a bug in

  https://github.com/nmbooker/stripansi/issues

or send me a pull request.

# Copyright

```
Strip terminal ANSI colour sequences out of input.

Copyright (C) 2013-2022     Nicholas Martin Booker <NMBooker@gmail.com>

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
