import Command.Branch ( gtBranch )

main :: IO ()
main = do
    branch <- gtBranch
    case branch of
        Nothing -> putStrLn "WAT. Weird HEAD link" 
        Just name -> putStrLn $ name
