import Command.Branch ( gtBranch )

main :: IO ()
main = do
    branch <- gtBranch
    case branch of
        Nothing -> putStrLn "At no branch"
        Just name -> putStrLn $ name
