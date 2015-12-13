# dotfiles
These are my rc files, or other configuration files. No guarantees that
these will work for anyone else, but they might!

Dependencies
============
* Vim:
    * janus (https://github.com/carlhuda/janus) to manage vim plugins,
      etc.
    * Other vim plugins that don't come with janus:
        * YouCompleteMe (https://github.com/Valloric/YouCompleteMe):
          Auto-code completion. The file `.ycm_extra_conf.py` in the
          `mongo` directory is the configuration I use when developing
          MongoDB.
        * A.vim (https://github.com/vim-scripts/a.vim): Easily switch
          between .h and .cpp by typing ":A".
        * vim-gitgutter (https://github.com/airblade/vim-gitgutter):
          Highlight which code you've changed that isn't committed yet.
        * tern-for-vim (https://github.com/ternjs/tern_for_vim): Helps
          with jumping to definitions in JavaScript code.
        * vim-clang-format (https://github.com/rhysd/vim-clang-format):
          auto-formats C++ code to ensure I follow the style guide.
* zsh as the shell, and oh-my-zsh (http://ohmyz.sh)
* grc (optional) to colorize output from various commands, mostly
  running tests for MongoDB.

Installation
============
General
-------
The following will need to be symlinked to the home directory (~):
* .zshrc
* .vimrc.after
* .vimrc.before

To set up the additional vim plugins, you'll need to clone all
repositories listed in the 'Other vim plugins' bullet of the
Dependencies section into the directory `~/.janus`.

Vim Colors
----------
I added some custom syntax highlighting to some languages that are of
interest to me. If you'd like to use these, link everything in the
vim-syntaxes folder into the `~/.vim/after/syntax/` directory, creating
it if it doesn't exist.

GRC
---
Optionally, you can use grc to colorize the output of various commands.
This is mostly useful for the output from MongoDB's test runner,
resmoke.py

To set up, link `grc/conf.resmoke` to the directory `~/.grc` (You'll
probably have to create that directory), then link `etc/grc.zsh` to
`/etc/grc.zsh`.

MongoDB
-------
All files mentioned in this section live in the `mongo` directory.

You'll need to link the file `mongo_shell.js` into the directory
`~/.janus/tern_for_vim/node_modules/tern/plugin/` in order for tern to
understand MongoDB's javascript (credit to Mathias for making that
work).

Link `.ycm_extra_conf.py` (configures code completion), `.eslintrc`
(configures linting of javascript files), and `.tern-project`
(configures code navigation) into the root of your mongo repository.

Link `my_agg.yml` into `buildscripts/resmokeconfig/suites`.

Link `git/info/exclude` to `.git/info/exclude`, or add whichever things
in that file seem relevant (most of the files mentioned here at least)
to your existing `.git/info/exclude`.
