module Command.Init where

import System.Process

main = do 
          result <- system "git init"
          return ()
