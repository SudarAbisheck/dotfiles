let mapleader=" "
"key mappings to normal vim actions
nnoremap / /\v
vnoremap / /\v
nnoremap ; :

"https://stackoverflow.com/a/20418591
au FocusGained,BufEnter * :silent! !          "load changes made out of vim
au FocusLost,WinLeave * :silent! noautocmd w  "autosave

nnoremap <tab> %
vnoremap <tab> %
nnoremap <leader>qt :tabonly<CR>
nnoremap <leader>t :tabnew<CR>
nnoremap <leader>q :q<CR>
nnoremap Q :q!<CR>                             "avoid entering ex mode
nnoremap <leader>w :w<CR>
nnoremap <leader>x :x<CR>
nnoremap <leader>ev :tabe ~/dotfiles/nvim-config/init.vim<CR>
nnoremap <leader>ef :tabe ~/dotfiles/fish-config/config.fish<CR>
nnoremap <leader>so :so $MYVIMRC<CR>
nnoremap <leader>p :set paste! <CR>
nnoremap <leader>sr :%s/
nnoremap <Leader>g gg=G<bar>gi<Esc>             "jump to last edited line
"noremap <leader>s :update<CR>
inoremap jk <Esc>
vnoremap jk <Esc>
nnoremap j gj
nnoremap k gk
nnoremap 0 g0
nnoremap $ g$
nnoremap > :tabnext<CR>
nnoremap < :tabprevious<CR>
vmap <Tab> >
vmap <S-Tab> <
nnoremap <Leader>te :tabe 
nnoremap F :bnext<CR>
nnoremap B :bprevious<CR>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
"nnoremap <C-t> :tabe<cr>:CtrlP<cr>
" Copy to 'clipboard registry'
vmap <C-c> "+y
nmap <C-a> ggVG
vmap <C-x> dd

inoremap <C-o> <ESC>o

nnoremap <Leader>ut :UndotreeToggle<cr>
nnoremap <Leader>tb :TagbarToggle<cr>
nnoremap <F8> :TagbarToggle<CR>
nnoremap <F5> :UndotreeToggle<CR>

"map arrowkey to change viewports size
nnoremap <Right> :vertical resize -5<CR>
nnoremap <Left> :vertical resize +5<CR>
nnoremap <Down> :resize -5<CR>
nnoremap <Up> :resize +5<CR>

"key mappings for plugins
nnoremap <leader>n :NERDTreeTabsToggle<CR>
nnoremap <leader>nt :NERDTree<CR>
" nnoremap <leader>fc :VimFilerCurrentDir<CR>
" nnoremap <leader>fb :VimFilerBufferDir<CR>
" nnoremap <leader>fi :VimFilerExplorer<CR>
" nnoremap <leader>vs :VimShellPop<CR>
" nnoremap <leader>vt :VimShellTab<CR>


"neosnippet
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <expr><TAB>
\ pumvisible() ? "\<C-n>" :
\ neosnippet#expandable_or_jumpable() ?
\    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

""" LanguageClient bindings
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" Or map each action separately
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> gr :call LanguageClient#textDocument_references()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
nnoremap <silent> <leader>c :call LanguageClient#textDocument_codeAction()<CR>
nnoremap <silent> <leader>e :call LanguageClient#explainErrorAtPoint()<CR>
nnoremap <silent> pc :pclose<CR>  "close all preview windows. useful when using LC

""" Easymotion
map <leader>m <Plug>(easymotion-prefix)
let g:EasyMotion_do_shade = 0 "Disable shading

" denite
call denite#custom#option('default', {
      \ 'prompt': '❯'
      \ })

call denite#custom#var('file/rec', 'command',
      \ ['rg', '--files', '--vimgrep'])
call denite#custom#var('grep', 'command', ['rg'])
call denite#custom#var('grep', 'default_opts',
      \ ['--hidden', '--vimgrep', '--smart-case'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])
call denite#custom#option('_', 'max_dynamic_update_candidates', 100000)
call denite#custom#option('_', {
      \ 'split': 'floating',
      \ 'highlight_matched_char': 'Underlined',
      \ 'highlight_matched_range': 'NormalFloat',
      \ 'wincol': &columns / 6,
      \ 'winwidth': &columns * 2 / 3,
      \ 'winrow': &lines / 6,
      \ 'winheight': &lines * 2 / 3
      \ })

autocmd FileType denite call s:denite_settings()

function! s:denite_settings() abort
  nnoremap <silent><buffer><expr> <CR>
        \ denite#do_map('do_action')
  nnoremap <silent><buffer><expr> <C-v>
        \ denite#do_map('do_action', 'vsplit')
  nnoremap <silent><buffer><expr> <C-s>
      \ denite#do_map('do_action', 'split')
  nnoremap <silent><buffer><expr> d
        \ denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p
        \ denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> <Esc>
        \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> q
        \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> i
        \ denite#do_map('open_filter_buffer')
endfunction

autocmd FileType denite-filter call s:denite_filter_settings()

function! s:denite_filter_settings() abort
  nmap <silent><buffer> <Esc> <Plug>(denite_filter_quit)
endfunction

nnoremap <C-p> :<C-u>Denite file/rec -start-filter<CR>
nnoremap <leader>s :<C-u>Denite buffer<CR>
nnoremap <leader>8 :<C-u>DeniteCursorWord grep:.<CR>
nnoremap <leader>/ :<C-u>Denite -start-filter grep:::!<CR>
nnoremap <leader><Space>/ :<C-u>DeniteBufferDir -start-filter grep:::!<CR>
nnoremap <leader>d :<C-u>DeniteBufferDir file/rec -start-filter<CR>
nnoremap <leader>r :<C-u>Denite -resume -cursor-pos=+1<CR>
nnoremap <leader><C-r> :<C-u>Denite register:.<CR>
nnoremap <leader>g :<C-u>Denite gitstatus<CR>


"Fugitive 
"nnoremap <silent> <leader>gs :Gstatus<CR>
"nnoremap <silent> <leader>ga :Git add -A<CR>
"nnoremap <silent> <leader>gd :Gdiff<CR>
"nnoremap <silent> <leader>gc :Gcommit<CR>
"nnoremap <silent> <leader>gp :Gpush<CR>
"nnoremap <silent> <leader>gl :Gpull<CR>
"nnoremap <silent> <leader>gr :Gremove<CR>
"nnoremap <silent> <leader>gb :Gbrowse<CR>
"vnoremap <silent> <leader>gb :Gbrowse<CR>
