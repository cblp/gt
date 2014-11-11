import Command.Log      ( gtLog )

import Git              ( commitLog, commitOid )
import Data.Tagged      ( untag )
import qualified Data.Text as Text


main :: IO ()
main = gtLog >>= mapM_ printCommit
    where

    printCommit c = putStrLn $ unwords
        [ take 7 $ show $ untag $ commitOid c
        , Text.unpack $ head $ Text.lines $ commitLog c
        ]
