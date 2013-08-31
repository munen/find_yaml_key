function! find_yaml_key#FindYamlKey(pat)
  let s = ""
ruby << EOF
  pat = VIM::evaluate 'a:pat'
  pat = pat.gsub("\.", ":\\\\\\n\ *")
  s = "normal! gg/#{pat}/e+1\\<cr>"
  VIM::command "let s = \"#{s}\""
  VIM::command "silent execute s"
EOF
endfunction
