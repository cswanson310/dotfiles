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

MongoDB
-------
All files mentioned in this section live in the `mongo` directory.

You'll need to put the file `mongo_shell.js` in the directory
`~/.janus/tern_for_vim/node_modules/tern/plugin/` in order for tern to
understand MongoDB's javascript (credit to Mathias for making that
work).

Put `.ycm_extra_conf.py` (configures code completion), `.eslintrc`
(configures linting of javascript files), and `.tern-project`
(configures code navigation)  at the root of your mongo repository.

Put `my_agg.yml` in `buildscripts/resmokeconfig/suites`.

Put `git/info/exclude` in `.git/info/exclude`, or add whichever things
in that file seem relevant (most of the files mentioned here at least)
to your existing `.git/info/exclude`.
