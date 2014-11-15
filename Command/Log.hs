module Command.Log (gtLog) where

import Git          ( Commit
                    , MonadGit
                    , Object(CommitObj)
                    , lookupCommitParents
                    , lookupObject
                    , resolveReference
                    , withRepository
                    )
import Git.Libgit2  ( lgFactory )
import Gt           ( GtCommit )


gtLog :: IO [GtCommit]
gtLog =
    withRepository lgFactory "." $ do
        mHeadOid <- resolveReference "HEAD"
        case mHeadOid of
            Nothing -> return []
            Just headOid -> do
                CommitObj headCommit <- lookupObject headOid
                getBranchCommits headCommit


getBranchCommits :: MonadGit repo monadGit =>
                    Commit repo -> monadGit [Commit repo]
getBranchCommits commit = do
    parents <- lookupCommitParents commit
    ancestors <- case parents of
        []              -> return []
        firstParent:_   -> getBranchCommits firstParent
    return $ commit:ancestors
