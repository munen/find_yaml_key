" exit if already loaded
if exists("g:find_yaml_key")
  finish
endif

if !has("ruby")
  echohl ErrorMsg
  echon "FindYamlKey requires ruby support."
  finish
endif

" declare as loaded
let g:find_yaml_key = "true"


command! -nargs=1 FindYamlKey call find_yaml_key#FindYamlKey(<f-args>)
