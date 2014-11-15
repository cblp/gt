import System.Directory ( setCurrentDirectory )
import System.Exit      ( exitFailure, exitSuccess )
import System.IO.Temp   ( withSystemTempDirectory )
import Test.HUnit       ( Test(TestCase), assertEqual, failures, runTestTT )

-- internal modules
import Command.Branch   ( gtBranch )
import Command.Init     ( gtInit )


main :: IO ()
main = do
    testResult <- runTestTT $ TestCase $
        withSystemTempDirectory "" $ \tmp -> do
            setCurrentDirectory tmp
            gtInit
            mbranch <- gtBranch
            assertEqual "gtBranch" (Just "master") mbranch
    if failures testResult /= 0
        then exitFailure
        else exitSuccess
