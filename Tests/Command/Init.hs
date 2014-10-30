import Control.Monad            ( guard )
import System.Directory         ( doesDirectoryExist, setCurrentDirectory )
import System.IO.Temp           ( withSystemTempDirectory )

-- internal modules
import qualified Command.Init   ( main )


main :: IO ()
main =
    withSystemTempDirectory "" $ \tmp -> do
        setCurrentDirectory tmp
        Command.Init.main
        guard =<< doesDirectoryExist ".git"
