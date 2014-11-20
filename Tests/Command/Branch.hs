import System.Directory ( setCurrentDirectory )
import System.Exit      ( ExitCode(ExitSuccess), exitFailure, exitSuccess )
import System.IO.Temp   ( withSystemTempDirectory )
import System.Posix     ( setEnv )
import System.Process   ( system )
import Test.HUnit       ( Test(TestCase), assertEqual, failures, runTestTT )

-- internal modules
import Command.Branch   ( gtBranch )
import Command.Init     ( gtInit )


main :: IO ()
main = do
    setEnv "GIT_EDITOR" "false" True
    testResult <- runTestTT $ TestCase $
        withSystemTempDirectory "" $ \tmp -> do
            setCurrentDirectory tmp
            gtInit
            gtBranch >>= assertEqual "gtBranch" (Just "master")
            runGit "commit --allow-empty --message=message"
            runGit "checkout $(git rev-parse HEAD)"
            gtBranch >>= assertEqual "gtBranch" Nothing
    if failures testResult /= 0
        then exitFailure
        else exitSuccess


run :: String -> IO ()
run cmd = system cmd >>= assertEqual cmd ExitSuccess

runGit :: String -> IO ()
runGit cmd =
    run $ "git "
        ++ unwords ["-c " ++ k ++ "=" ++ v | (k, v) <- config]
        ++ " "
        ++ cmd
    where config = [("user.email", "test@example.org")]
