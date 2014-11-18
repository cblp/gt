module Command.Branch where

import Git          ( withRepository, MonadGit)
import Git.Libgit2  ( lgFactory )
import Git.Types    ( lookupReference, RefTarget(..) )
import qualified Data.Text as Text

currentBranch :: MonadGit repo monadGit => monadGit (Maybe String)
currentBranch = do
    ref <- lookupReference "HEAD"
    case ref of
        Nothing -> return Nothing
        Just reftarget ->
            case reftarget of
                RefObj _ -> return Nothing
                RefSymbolic refname -> return $ Just $ Text.unpack $ last $ Text.splitOn "/" refname

gtBranch :: IO (Maybe String)
gtBranch =
    withRepository lgFactory "." $ do
        branch <- currentBranch
        return $ branch
