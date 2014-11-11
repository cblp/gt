module Command.Log (gtLog) where

import Git
import Git.Libgit2              ( LgRepo, lgFactory )


type GtCommit = Commit LgRepo


gtLog :: IO [GtCommit]
gtLog =
    withRepository lgFactory "." $ do
        mHeadOid <- lookupReferenceOid "HEAD"
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


lookupReferenceOid ::   MonadGit repo monadGit =>
                        RefName -> monadGit (Maybe (Oid repo))
lookupReferenceOid refname = do
    mref <- lookupReference refname
    case mref of
        Nothing                     -> return Nothing
        Just (RefObj oid)           -> return $ Just oid
        Just (RefSymbolic refname') -> lookupReferenceOid refname'
