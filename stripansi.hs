-- Strip ansi colour escape sequences from stdin.
-- output is on stdout

main :: IO ()
main = interact removeANSIColourCodes

data State = InText | InANSICode

removeANSIColourCodes :: String -> String
removeANSIColourCodes = stateMachine InText

-- An ANSI colour code is "\x1b" ++ some_numeric_string ++ "m"
stateMachine :: State -> String -> String
stateMachine _ [] =
    []
stateMachine InText ('\x1b':xs) =
    stateMachine InANSICode xs
stateMachine InText (x:xs) =
    x:(stateMachine InText xs)
stateMachine InANSICode ('m':xs) =
    stateMachine InText xs
stateMachine InANSICode (x:xs) =
    stateMachine InANSICode xs


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
