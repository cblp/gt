import Command.Branch ( gtBranch )
import qualified Data.Text as Text

main :: IO ()
main = do
    refname <- gtBranch
    case refname of
        Nothing -> putStrLn "WAT. Weird HEAD link" 
        Just name -> putStrLn $ Text.unpack $ last $ Text.splitOn "/" name
