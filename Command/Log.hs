module Command.Log (gtLog) where

import Control.Monad.IO.Class   ( liftIO )
import Data.Maybe               ( fromMaybe )
import Data.Tagged              ( untag )
import Git
import Git.Libgit2              ( lgFactory )
import qualified Data.Text as Text


gtLog :: IO ()
gtLog =
    withRepository lgFactory "." $ do
        headOid <-  lookupReferenceOid "HEAD"
                    $> fromMaybe (error "Cannot resolve HEAD")
        CommitObj headCommit <- lookupObject headOid
        branch <- getBranchCommits headCommit
        liftIO $ mapM_ printCommit branch

    where

    printCommit c = putStrLn $ unwords
        [ take 7 $ show $ untag $ commitOid c
        , Text.unpack $ head $ Text.lines $ commitLog c
        ]


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


($>) :: Functor functor => functor a -> (a -> b) -> functor b
($>) = flip fmap
