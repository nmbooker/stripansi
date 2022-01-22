module Main where
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
stateMachine InANSICode (_:xs) =
    stateMachine InANSICode xs

