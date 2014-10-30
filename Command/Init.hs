module Command.Init where

import Control.Monad            ( guard )
import Control.Monad.Trans.Error( {- MonadPlus IO -- for guard -} )
import System.Exit              ( ExitCode(ExitSuccess) )
import System.Process           ( system )


main :: IO ()
main = do
    exitCode <- system "git init"
    guard $ exitCode == ExitSuccess
