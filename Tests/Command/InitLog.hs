import Control.Monad            ( guard )
import System.Directory         ( doesDirectoryExist, setCurrentDirectory )
import System.IO.Temp           ( withSystemTempDirectory )

-- internal modules
import Command.Init             ( gtInit )
import Command.Log              ( gtLog )


main :: IO ()
main =
    withSystemTempDirectory "" $ \tmp -> do
        setCurrentDirectory tmp
        gtInit
        guard =<< doesDirectoryExist ".git"
        commits <- gtLog
        guard $ null commits
