" Various matches.
syn match   cCustomClass      "\zs\w\+\ze::"
syn match   cCustomFuncOrType "::\zs\w\+\ze("
syn match   cppType           "\(const \)\?\zs[A-Za-z][A-Za-z<>_:]\+\ze\*\?&\? &\?[_A-Za-z]\+" nextgroup=cVariableName contains=cVariableName
syn match   cMemberVariable   "[([ >+*!&]\zs_[a-z][A-Za-z]*\ze"
syn match   cMacro            "\zs[A-Z_]\{2,}\ze[^A-Za-z]"

hi def link cCustomClass      Structure
hi def link cCustomFuncOrType Function
hi def link cppType           Type
hi def link cMemberVariable   Identifier
hi def link classVisibilities Identifier

" Keywords.
syn keyword mongoAsserts      uassert massert fassert dassert
syn keyword BSONTypes         MinKey EOO NumberDouble String Object Array BinData Undefined jstOID Bool Date jstNULL RegEx DBRef Code Symbol CodeWScope NumberInt bsonTimestamp NumberLong NumberDecimal JSTypeMax MaxKey
syn keyword Return            return
syn keyword classVisibilities private public protected

hi def link cMacro            Keyword
hi def link mongoAsserts      Keyword
hi def link BSONTypes         Keyword
hi def link Return            Keyword
