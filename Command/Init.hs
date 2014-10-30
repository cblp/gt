module Init where 

import System.Process

main = do 
          result <- callCommand "git init"
          return ()
