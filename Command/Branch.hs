module Command.Branch where

import Git          ( withRepository)
import Git.Libgit2  ( lgFactory )
import Git.Types    ( lookupReference, RefTarget(..) )
import qualified Data.Text as Text

refName :: Maybe (RefTarget r) -> Maybe String
refName reftarget = do
    r <- reftarget
    case r of
        RefObj _ -> fail ""
        RefSymbolic refname -> return $ Text.unpack $ last $ Text.splitOn "/" refname

gtBranch :: IO (Maybe String)
gtBranch =
    withRepository lgFactory "." $ do
        ref <- lookupReference "HEAD"
        return $ refName ref
