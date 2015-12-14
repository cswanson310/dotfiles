syntax match jsDocParamDefaultStart contained "=" nextgroup=jsDocParamDefault
syntax match jsDocParamDefault contained "\%(\"\|\'\|\[[^]]*\]\|\d\|\w\|\.\)\+" nextgroup=jsDocParamDefaultEnd
syntax match jsDocParamDefaultEnd contained "\] "

hi link jsReturn Function
hi link jsObjectKey Constant
hi link jsFunctionKey Constant
hi link jsDocParamDefault Constant
hi link jsCommentTodo Identifier
