function! find_yaml_key#FindYamlKey(pat)
  let s = ""
ruby << EOF
  pat = VIM::evaluate 'a:pat'
  t_pat = pat.gsub("\.", ":\\\\\\n\ *")
  s = "normal! gg/#{t_pat}/e+1\\<cr>"
  VIM::command "let s = \"#{s}\""
  VIM::command "execute \"try | s | catch | " \
                 "echohl ErrorMsg | " \
                 "echom 'Key #{pat} does not exist' | "\
               "endtry\""
EOF
endfunction
