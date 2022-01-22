-- Strip ansi colour escape sequences from stdin.
-- output is on stdout
--
-- Copyright (c) 2022 Nicholas Martin Booker <NMBooker@gmail.com>
-- 
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
-- 
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
-- 
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.

---------------------------------------------------------------------------

-- Ansi escape sequences start with an ESC (0x1b) character, and end with an m
-- So we want to drop the ESC, and all following characters up to and including the next 'm'
-- We only want to keep the characters that are outside such a sequence.


main = interact $ rmescs

data State = InText | InANSICode

-- rmescs just starts off rescs.  When we start, we're not in an escape sequence.
rmescs :: String -> String
rmescs xs = rescs InText xs


rescs :: State -> String -> String
rescs _ [] =
    []
rescs InANSICode ('m':xs) =
    rescs InText xs
rescs InANSICode (x:xs) =
    rescs InANSICode xs
rescs InText ('\x1b':xs) =
    rescs InANSICode xs
rescs InText (x:xs) =
    x:(rescs InText xs)

