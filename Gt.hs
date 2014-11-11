module Gt where

import Git          ( Commit )
import Git.Libgit2  ( LgRepo )


type GtCommit = Commit LgRepo
