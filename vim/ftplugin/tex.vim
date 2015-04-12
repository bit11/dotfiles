"----------------------------------------------
" Vim Latex-Suite Macros
" /.vim/ftplugin/tex.vim
" Last updated 28 Nov 14
"----------------------------------------------

" Macro for chapter
:call IMAP('EC',"\\chapter{<++>}", 'tex')

" Macro for section
:call IMAP('ES',"\\section{<++>}", 'tex')

" Macro for subsection
:call IMAP('EB',"\\subsection{<++>}", 'tex')

" Macro for figure insertion
:call IMAP('EFF', "\\begin{figure}[htbp]\<CR>\\centering\<CR>\\includegraphics[scale=<++>]{<++>}\<CR>\\caption{<++>}\<CR>\\label{<++>}\<CR>\\end{figure}", 'tex')

" Macro for subfigure insertion
:call IMAP('EFS', "\\begin{figure}[htpb]\<CR>\\centering\<CR>\\begin{subfigure}[t]{0.45\\textwidth}\<CR>\\centering\<CR>\\includegraphics[scale=<++>]{<++>}\<CR>\\caption{<++>}\<CR>\\label{<++>}\<CR>\\end{subfigure}\\hfill\%\<CR>\\begin{subfigure}[t]{0.45\\textwidth}\<CR>\\centering\<CR>\\includegraphics[scale=<++>]{<++>}\<CR>\\caption{<++>}\<CR>\\label{<++>}\<CR>\\end{subfigure}\<CR>\\caption{<++>}\<CR>\\label{<++>}\<CR>\\end{figure}", 'tex')

" Macro for table insertion
:call IMAP('EFT', "\\begin{table}[htbp] \\footnotesize\<CR>\\centering\<CR>\\caption{<++>}\<CR>\\begin{tabular}{<++>} \\hline\<CR><++> \\hline\<CR>\\end{tabular}\<CR>\\label{<++>}\<CR>\\end{table}", 'tex')

" Macro for list (itemize) insertion
:call IMAP('EFE', "\\begin{itemize}\<CR>\\item <++>\<CR>\\end{itemize}", 'tex')

" Macro for list (enumerate) insertion
:call IMAP('EFN', "\\begin{enumerate}\<CR>\\item <++>\<CR>\\end{enumerate}", 'tex')

" Override built-in equation environment
let g:Tex_Env_{'equation'} = 
            \ "\\begin{equation}\<CR><++> \<CR>\\label{<++>}\<CR>\\end{equation}"

set grepprg=grep\ -nH\ $*
let g:tex_flavor = "pdflatex"						" Set latex mode as pdflatex
"set runtimepath=~/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,~/.vim/after
let g:Tex_DefaultTargetFormat='pdf'					" Set default format as pdf, not dvi
let g:Tex_MultipleCompileFormats='pdf, aux'			" Run compiler multiple times to comple bibtex and pdflatex
"hi Folded ctermbg=white
augroup latex_spellcheck
    autocmd!
    autocmd FileType tex setlocal spell spelllang=en_gb " Set spellcheck for latex only
augroup END
