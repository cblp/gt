module Command.Branch where

import Git          ( withRepository, RefName )
import Git.Libgit2  ( lgFactory )
import Git.Types    ( lookupReference, RefTarget(..) )


gtBranch :: IO (Maybe RefName)
gtBranch = do
    withRepository lgFactory "." $ do
        ref <- lookupReference "HEAD"
        case ref of
            Nothing -> return Nothing
            Just reftarget -> do
                case reftarget of
                    RefObj _ -> return Nothing
                    RefSymbolic refname -> return $ Just refname
