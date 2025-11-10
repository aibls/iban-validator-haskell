type Codes = [(String, Int)]

codes :: Codes
codes = [("GB",22), ("GR",27), ("SA",24), ("CH",21), ("IL",23)]

-- | Checks whether a given block (1–4 characters) is valid.
isValidBlock :: String -> Bool
isValidBlock block = if (block /= "") && not (any (`elem` ['a'..'z']) block) && (length block <= 4) && ((elem) '0' block || (elem) '1' block || (elem) '2' block || (elem) '3' block || (elem) '4' block || (elem) '5' block || (elem) '6' block || (elem) '7' block|| (elem) '8' block || (elem) '9' block || any (`elem` ['A'..'Z']) block)
                        then True 
                        else False

-- | Checks if a given country code exists in the supported 'codes' list.
isValidCountryCode :: String -> Bool
isValidCountryCode code = if any (\(x,s) -> x == code) codes then True else False 

-- | Retrieves the expected IBAN length for a given country code.
getLength :: String -> Int
getLength code = snd(head (filter (\(x,s) -> x == code) codes))

-- | Removes all spaces from a string (e.g., "GB29 NWBK ..." → "GB29NWBK...").
pack :: String -> String
pack s = filter (\x -> x /= ' ') s

-- | Checks whether an IBAN string is well-formed according to format rules.
isWellFormed :: String -> Bool
isWellFormed iban = 
    isValidCountryCode country && 
    length ibanwithoutspaces == getLength country &&
    not (any (`elem` ['a'..'z']) ibanwithoutspaces) &&
    all isValidBlock (words iban)
    where 
        country = take 2 iban
        ibanwithoutspaces = pack iban

-- | Converts alphabetic chars in an IBAN to numeric equivalents A=10..Z=35.
resolve :: String -> String
resolve s = foldr (++) "" (map (\c -> if c >= 'A' && c <= 'Z' then show (fromEnum c - 55) else [c]) s)

-- | Converts a string of digits into an Integer. Empty input returns 0.
numerize :: String -> Integer
numerize s = if s == "" then 0 else read s

-- | Mathematical IBAN validation (mod 97).
isValidIBAN :: String -> Bool
isValidIBAN s = let moved = drop 4 s ++ take 4 s
                    res = resolve moved
                    num = numerize res
                in if num `mod` 97 == 1 then True else False
