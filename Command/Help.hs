module Command.Help where

gtHelp :: IO ()
gtHelp = do 
    putStrLn "gt-help | Gives a short description for each command \n\
             \gt-init | Initializes a new gt/git repository"
