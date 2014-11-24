module Command.Branch where

import Git          ( withRepository)
import Git.Libgit2  ( lgFactory )
import Git.Types    ( lookupReference, RefTarget(..) )
import qualified Data.Text as Text

refName :: RefTarget r -> Maybe String
refName reftarget =
    case reftarget of
        RefObj _ -> Nothing
        RefSymbolic refname -> return $ Text.unpack $ last $ Text.splitOn "/" refname

gtBranch :: IO (Maybe String)
gtBranch =
    withRepository lgFactory "." $ do
        ref <- lookupReference "HEAD"
        return $ (ref >>= refName)
