" private helper function to execute commands that fail gracefully
function! s:Perform(method, error_message)
  try
    silent execute a:method
  catch
    echohl ErrorMsg
    echon a:error_message
  endtry
endfunction


" public interface for the FindYamlKey plugin
" @param [String] nested yaml key; i.e. foo.bar.baz
function! find_yaml_key#FindYamlKey(pat)
ruby << EOF
  # read vimscript variable to ruby
  pat = VIM::evaluate 'a:pat'
  # replace '.' with ':\_.\{-}', so search over multiple lines can happen
  # regexp explanation:
  #    * \_. matches everything including multiple newlines
  #    * \{-} acts like '*', but is non-greedy. Needed to not match inside the
  #      translation, but only the key.
  t_pat = pat.gsub("\.", ":\\\\\\_.\\\\\\{-}")
  # construct vim search from top of buffer
  method = "normal! gg/#{t_pat}/e+1\\<cr>"
  # error_message, in case key cannot be found
  error_message = "Key '#{pat}' does not exist"

  VIM::command "call s:Perform(\"#{method}\", \"#{error_message}\")"
EOF
endfunction
