gt
==

**[git](http://git-scm.com/)** is very flexible and powerful persistent file storage.
It also can be used as a source code version control system.

**gt** is an attempt to build a more usable VCS, fixing several git shortcomings.

gt will be implemented as a set of CLI tools.

Development process
-------------------

This project is used as a teaching material 
by [Perunity Haskell group][].
Anybody can take part in the project throw implementing a new feature or fixing a bug.
Just create an issue in this project or assign an existing issue to yourself.
When participating in development, you can ask any questions on Haskell language,
functional programming techniques or programming techonologies in general,
if it is needed for your task.

Rules
-----

1. Where can mentee ask
    - In the issue comments.
    - [Perunity Haskell group][].
2. Mentors must do the best efforts to answer questions, if
    - the feature is useful for the project and
    - the method chosen to implement the feature is reasonable.

  A good mentor may answer other questions too.

[Perunity Haskell group]: http://www.perunity.com/group/21

Installing dependencies
-----------------------

    $ cabal update  # if you didn't before
    $ cabal install --only-dependencies

If you have conflicts with installed packages like

    $ cabal install --only-dependencies
    Resolving dependencies...
    In order, the following would be installed:
    .
    .
    .
    cabal: The following packages are likely to be broken by the reinstalls:
    .
    .
    .
    Use --force-reinstalls if you want to install anyway.

then do

    $ cabal sandbox init
    $ cabal install --only-dependencies --force-reinstalls

It will install packages into a sandbox in current directory,
and won't break cabal packages installed globally.

Building
--------

    $ cabal build

Testing
--------

    $ cabal test --ghc-option=-Werror
