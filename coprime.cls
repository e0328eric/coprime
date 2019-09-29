%%==============================================================================================================

%% This class has a copywrite to Coprime --- Ver : 2.00
%% Email Address : almagest0328@gmail.com
%% Encoded by UTF-8
%
%% coprime Class, First Release Date : 2018/06/31
%
%% Ver 2.00b : 18/06/31 --- Release in Class mod
%
%% Ver 2.10b : 18/07/11 --- Big Update! (First using Key macro to make a class)
%% Ver 2.11b : 18/07/11 --- Delete \spaceskip to solve the issue which is auto line skip error
%% Ver 2.12b : 18/07/14 --- Add cleveref package
%% Ver 2.13b : 18/07/17 --- Add fouridx package
%
%% Ver 2.20b : 18/08/05 --- Geometry and Babel options can be fully used!
%
%% Ver 2.30b : 18/08/06 --- Add no capitalization of title
%% Ver 2.31b : 18/08/06 --- Fix a bug where head of last page is different with others
%% Ver 2.32b : 18/08/20 --- Add multirow package
%
%% Ver 2.40b : 18/10/06 --- Add cleveref package and add two new commands: \contradiction and \not
%
%% Ver 2.50b : 18/10/09 --- Reedit font names
%% Ver 2.51b : 18/10/15 --- Make \idx command
%% Ver 2.52b : 18/10/16 --- Fix the error of \es and add \converge command
%% Ver 2.53b : 18/10/17 --- Add accent package and make \accent command
%% Ver 2.54b : 18/11/02 --- Add fancythm option (But this has some error...)
%% Ver 2.55b : 18/11/03 --- Fix the error when fancythm is off
%% Ver 2.56b : 18/11/03 --- Now, to use easily, TTReport envionment is deleted. Use \setting instead.
%			    Also, delete \accent command and add leqno class option.
%% Ver 3.00b : 18/11/05 --- Huge Update!!! Change the name to KUReport
%% Ver 3.01b : 18/11/05 --- Now you can edit head using \sethead. There is a bug when the foot line
%%                          is on. Add hangul option too
%% Ver 3.02b : 18/11/07 --- Change base geometry to fix the problem of \setfoot
%% Ver 3.03b : 18/11/08 --- Reedit font commands
%% Ver 3.04b : 18/11/10 --- Use article class instead of amsart class. And... something else lol
%% Ver 3.05b : 18/11/10 --- Fix \C command which caused the error and babel bold issue
%% Ver 3.06b : 18/11/11 --- Adding multicol option and package
%% Ver 3.07b : 18/11/13 --- More Fancy Theorem box
%% Ver 3.08b : 18/12/09 --- Add version option and add TTReport environment
%
%% Ver 3.10b : 18/12/10 --- Edit the class slightly and fix the bug
%% Ver 3.11b : 18/12/12 --- Change the math font. Add \ds command and define \bbb{1} as \ds{1}.
%%                           If you want to use stix font, downgrade the version of this package.
%% Ver 3.12b : 18/12/13 --- Use mathabx font in final
%
%% Ver 3.20b : 18/12/13 --- Making \not command perfectly!
%% Ver 3.21b : 18/12/13 --- Bug fix
%
%% Ver 3.30b : 18/12/15 --- Make a new command : \Matrix
%
%% Ver 0.00 : 18/12/19 --- Change the class with LaTeX3 Language. Class name is changed and fancythm fixed
%% Ver 0.01 : 18/12/29 --- Add stix2-type 1 font, delete mathabx font
%% Ver 0.02 : 19/01/05 --- Fixed \usegeometry, \setbabel and \sethyperlink issues
%
%% Ver 0.10 : 19/01/21 --- Can be used in LuaTeX but not XeTeX
%% Ver 0.11 : 19/01/23 --- Fix the issue when using hyperlink option
%% Ver 0.12 : 19/02/22 --- Edit the \Matrix command
%
%% Ver 1.00 : 19/02/25 --- Major Update!
%
%% Ver 1.10 : 19/02/28 --- Make the titlepage
%% Ver 1.11 : 19/03/06 --- Fix bugs.
%% Ver 1.12 : 19/03/15 --- Delete hangul and hanja options
%
%% Ver 1.20 : 19/03/17 --- Add reference environment to use bibtex easely
%% Ver 1.21 : 19/03/22 --- Fix the bug when .bib file made although the reference environment
%			   does not active and change the default code of \Matrix command
%% Ver 1.22 : 19/03/28 --- Add etoolbox package which makes command more efficiently
%% Ver 1.23 : 19/04/16 --- Edit fancythm style
%% Ver 1.24 : 19/06/24 --- Fix some issues of fancythm style
%% Ver 1.25 : 19/07/20 --- Fix some issues when using LuaTeX engine
%
%% Ver 2.00 : 19/07/22 --- Remake class to work well when using LuaTeX
%===============================================================================================================

% LaTeX Format and Define Class Name
\NeedsTeXFormat{LaTeX2e}
\RequirePackage{expl3, xparse, l3keys2e}
\ProvidesExplClass {coprime} {2019/07/22} {2.00} {Copywrite to Coprime}

% Define Version Constant
\tl_const:Nn \c__current_version_tl {2.00}

%Declare Booleans
\bool_new:N \g_custom_titlepage_bool
\bool_new:N \g_foot_edit_bool
\bool_new:N \g_geometry_used_bool
\bool_new:N \g_head_edit_bool
\bool_new:N \g_hyperlink_used_bool
\bool_new:N \g_multicolumn_end_bool
\bool_new:N \g_multicolumn_end_star_bool
\bool_new:N \g_title_author_empty_bool
\bool_set_true:N \g_title_author_empty_bool
\bool_new:N \g_version_new_bool
\bool_set_true:N \g_version_new_bool

%Declare Most Important!
\tl_new:N \title_tl
\tl_new:N \author_tl
\tl_new:N \date_tl
\fp_new:N \baseline_fp
\sys_if_engine_pdftex:TF
{%
\fp_set:Nn \baseline_fp {1.06}
}
{%
\fp_set:Nn \baseline_fp {1.02}
}
\dim_new:N \parindent_dim
\dim_new:N \parskip_dim
\dim_set:Nn \parindent_dim {11pt}
\dim_set:Nn \parskip_dim {0em}

%Declare Dimention
\dim_new:N \font_size_dim
\dim_set:Nn \font_size_dim {11pt}

%Interchanging Control Sequence
\cs_new:Npn \cop_change_commds:N #1
	{%
		\cs_new:cn
	}

%Declare Options
\keys_define:nn {CPOpt}
	{%
		babel .code:n = {\ClassError{Obsolete~option. ~Use~babel~option~instead.}{Use~babel~option~instead.}},
     	fancythm .bool_set:N = \g_fancythm_bool,
     	fontsize .code:n = {\dim_set:Nn \font_size_dim {#1}},
		fontsize .default:n = 11pt,
     	geometry .bool_set:N = \g_geometry_bool,
     	hyperlink .bool_set:N = \g_hyperlink_bool,
     	item .bool_set:N = \g_item_bool,
    	korean .bool_set:N = \g_korean_bool,
     	leqno .bool_set:N = \g_leqno_bool,
     	multicol .bool_set:N = \g_multicol_bool,
		nobreak .bool_set:N = \g_nobreak_bool,
     	nostix .bool_set:N = \g_nostix_bool,
     	table .bool_set:N = \g_table_bool,
     	tcolorbox .bool_set:N = \g_tcolorbox_bool,
     	tikz .bool_set:N = \g_tikz_bool,
     	twoside .bool_set:N = \g_twoside_bool,
     	version .tl_set:N = \c__edited_version_tl,
		8pt .code:n = {\dim_set:Nn \font_size_dim {8pt}},
		9pt .code:n = {\dim_set:Nn \font_size_dim {9pt}},
		10pt .code:n = {\dim_set:Nn \font_size_dim {10pt}},
		11pt .code:n = {\dim_set:Nn \font_size_dim {11pt}},
		12pt .code:n = {\dim_set:Nn \font_size_dim {12pt}},
		13pt .code:n = {\dim_set:Nn \font_size_dim {13pt}},
	}

\keys_set:nn {CPOpt}
	{%
		version = \c__current_version_tl,
	}
\ProcessKeysOptions{CPOpt}

\tl_if_in:NnTF \c__edited_version_tl {b}
	{
		\tl_remove_all:Nn \c__edited_version_tl {b}
		\fp_set:Nn \c__edited_version_fp {-5+\tl_use:N \c__edited_version_tl}
	}
	{
		\fp_set:Nn \c__edited_version_fp {\tl_use:N \c__edited_version_tl}
	}

%reqno vs leqno
\bool_if:NTF \g_leqno_bool
	{%
		\LoadClass[leqno]{article}
	}
	{%
		\LoadClass{article}
	}

%Basic Usepackages
\sys_if_engine_ptex:T
	{
		\ClassError{coprime}{Use~'pdftex'~or~'luatex'~engine}{}
	}
\sys_if_engine_uptex:T
{
	\ClassError{coprime}{Use~'pdftex'~or~'luatex'~engine}{}
}
\sys_if_engine_xetex:T
{
	\ClassError{coprime}{Use~'pdftex'~or~'luatex'~engine}{}
}

\RequirePackage{amsmath,amssymb,amsthm,amsfonts}
\RequirePackage{mathrsfs, euscript}
\RequirePackage{mathtools}
\sys_if_engine_pdftex:TF
	{
		\fp_compare:nNnT {\fp_use:N \c__edited_version_fp} > {-1.985}
		{%
			\RequirePackage{mathtools}
		}
	}
	{
		\RequirePackage{fontspec}
		\RequirePackage[math-style=ISO]{unicode-math}
	}
\sys_if_engine_luatex:T
	{
		\RequirePackage{luacode}
	}
\RequirePackage{scalerel}
\RequirePackage{anyfontsize}
\RequirePackage{graphicx}
\RequirePackage{fancyhdr}
\RequirePackage{fouridx}
\RequirePackage{centernot}
\RequirePackage{relsize}
\RequirePackage{xcolor}
\RequirePackage{etoolbox}

\bool_if:NF \g_nobreak_bool
	{
		\allowdisplaybreaks
	}

%Korean Usepackage
\bool_if:NT \g_korean_bool
	{%
	    \RequirePackage{kotex}
	    \sys_if_engine_luatex:T
		{
		    \setmainhangulfont{Noto Serif CJK KR}[
			Scale=0.98,
			AutoFakeSlant,
			Script=Hangul,
			Language=Korean,
			LocalForms=On,
			UprightFont=* Light,
			BoldFont=* Bold,
			InterLatinCJK=.125em,
			Expansion, Protrusion,
		    ]
		    \setsanshangulfont{Noto Sans CJK KR}[
			Scale=0.98,
			Script=Hangul,
			Language=Korean,
			UprightFont=* DemiLight,
			BoldFont=* Bold,
			InterLatinCJK=.125em,
		    ]
		    \setmathhangulfont{Noto Sans CJK KR}[
			Script=Hangul,
			Language=Korean,
			SizeFeatures={
			{Size=-6,  Font=* Medium},
			{Size=6-9, Font=* Regular},
			{Size=9-,  Font=* DemiLight},
			},
		    ]
		}
	}

%Math Symbol
\sys_if_engine_pdftex:TF
	{
		\bool_if:NTF \g_nostix_bool
			{%
				\DeclareMathOperator*{\bigcupdot}{\ooalign{\hfil$\displaystyle\bigcup$\hfil\cr%
				\hfil\raise-.4ex\hbox{\larger[3]$\cdot$} \raise-1.17ex\hbox{}\hfil\cr}}
    			\newcommand{\cupdot}{\ooalign{\hfil$\cup$\hfil\cr\hfil$\cdot$\hfil\cr}}
    			\DeclareMathOperator{\nullint}{\scalerel*[0.1pt]{\phantom{|}}{\int}}
    			\newcommand{\upint}{\overline{\int}\hskip-1.5pt\nullint}
    			\newcommand{\lowint}{\underline{\int}\hskip-1.5pt\nullint}
    			\RequirePackage{dsfont}
			\let\oldemptyset\emptyset
			\let\emptyset\varnothing
			}
			{%
			\RequirePackage[upint]{stix2}
			\let\oldemptyset\emptyset
			\let\emptyset\varnothing
    			\renewenvironment{cases}{%
						\left\{\begin{matrix}
					}{%
						\end{matrix}\right.
					}
			}
	}
	{
		\bool_if:NTF \g_nostix_bool
		{
			\DeclareMathOperator*{\bigcupdot}{\ooalign{\hfil$\displaystyle\bigcup$\hfil\cr%
			\hfil\raise-.4ex\hbox{\larger[3]$\cdot$} \raise-1.17ex\hbox{}\hfil\cr}}
    		\newcommand{\cupdot}{\ooalign{\hfil$\cup$\hfil\cr\hfil$\cdot$\hfil\cr}}
    		\DeclareMathOperator{\nullint}{\scalerel*[0.1pt]{\phantom{|}}{\int}}
    		\newcommand{\upint}{\overline{\int}\hskip-1.5pt\nullint}
    		\newcommand{\lowint}{\underline{\int}\hskip-1.5pt\nullint}
    		\RequirePackage{mathrsfs, euscript, dsfont}
    		\setmainfont[Ligatures=TeX]{Linux Libertine O}
		}
		{
		    \setmainfont{STIX Two Text}
		    \setsansfont{Noto Sans CJK KR}
		    \setmathfont[StylisticSet=8]{STIX Two Math}
			\renewenvironment{cases}{%
					\left\{\begin{matrix}
				}{%
					\end{matrix}\right.
				}
		}
	}


%Item Option
\bool_if:NT \g_item_bool
	{%
		\RequirePackage{outlines}
		\RequirePackage{enumitem}
	}

%Table Option
\bool_if:NT \g_table_bool
	{%
		\RequirePackage{longtable}
		\RequirePackage{multirow}
		\RequirePackage{array}
		\RequirePackage{hhline}
	}

%Setting Geometry
\tl_set:Nn \tl_Margin_Setup {a4paper, margin = 1.3in, includeheadfoot, footskip = .4in}
\NewDocumentCommand{\setgeometry}{m}{
	\bool_set_true:N \g_geometry_used_bool
	\bool_if:NTF \g_geometry_bool
		{%
			\tl_if_blank:nTF {#1}
				{%
					\ClassWarning{coprime}{%
						Setting~basic~geometry~option~instead.
					}
				}
				{%
					\tl_set:Nn \tl_Margin_Setup {#1}
				}
		}
		{%
			\ClassError{coprime}{%
				Add~'geometry'~option~to~use~this~command
			}{%
				Add~'geometry'~option~to~use~this~command
			}
		}
	\RequirePackage[\tl_use:N \tl_Margin_Setup]{geometry}
}
\bool_if:NF \g_geometry_bool
	{%
		\RequirePackage[\tl_use:N \tl_Margin_Setup]{geometry}
	}

%Cleveref and Hyperref Package
\tl_gset:Nn \tl_Hyperlink_Setup {colorlinks = true, urlcolor = black!50!cyan, citecolor = magenta, linkcolor = blue}
\NewDocumentCommand{\sethyperlink}{m}{
	\bool_set_true:N \g_hyperlink_used_bool
	\bool_if:NTF \g_hyperlink_bool
		{%
			\tl_if_blank:nTF {#1}
				{%
					\ClassWarning{coprime}{%
						Setting~basic~hyperlink~option~instead.
					}
				}
				{%
					\tl_gset:Nn \tl_Hyperlink_Setup {#1}
				}
		}
		{%
			\ClassError{coprime}{%
				Add~'hyperlink'~option~to~use~this~command
			}{%
				Add~'hyperlink'~option~to~use~this~command
			}
		}
	\RequirePackage[\tl_use:N \tl_Hyperlink_Setup]{hyperref}
	\RequirePackage{cleveref}
}
\bool_if:NF \g_hyperlink_bool
	{%
		\RequirePackage{cleveref}
	}
%Reference
\newwrite\tf@bib
\newsavebox\box@bib
\newcommand\bib[1]{%
    \protected@write\@auxout{}{\string\@writefile{bib}{#1}}%
}
\NewDocumentEnvironment{reference}{O{plain}}{%
	\openout\tf@bib=\jobname.bib
	\let\NDC\NewDocumentCommand
	\NDC{\article}{mmmmO{}}{%
	\bib{@Article{##1,
			title={##2},
			author={##3},
			year={##4},
			##5}
		}
	}
	\NDC{\book}{smmmmmO{}}
	{\IfBooleanTF{##1}{%
		\bib{@Book{##2,
				title={##3},
				editor={##4},
				year={##5},
				publisher={##6},
				##7}
			}
		}{\bib{@Book{##2,
				title={##3},
				author={##4},
				year={##5},
				publisher={##6},
				##7}
			}
		}
	}
	\NDC{\booklet}{mmO{}}{%
	\bib{@Booklet{##1,
			title={##2},
			##3}
		}
	}
	\NDC{\inbook}{smmmmmmO{}}
	{\IfBooleanTF{##1}{%
		\bib{@Inbook{##2,
				title={##3},
				editor={##4},
				year={##5},
				chapter={##6}
				publisher={##7},
				##8}
			}
		}{\bib{@Inbook{##2,
				title={##3},
				author={##4},
				year={##5},
				chapter={##6}
				publisher={##7},
				##8}
			}
		}
	}
	\NDC{\incollection}{mmmmmmO{}}{%
	\bib{@Incollection{##1,
			title={##2},
			author={##3},
			booktitle={##4},
			year={##5},
			publisher={##6},
			##7}
		}
	}
	\NDC{\conference}{mmmmmO{}}{%
	\bib{@Conference{##1,
			title={##2},
			author={##3},
			booktitle={##4},
			year={##5},
			##6}
		}
	}
	\NDC{\manual}{mmO{}}{%
	\bib{@Manual{##1,
			title={##2},
			##3}
		}
	}
	\NDC{\master}{mmmmmO{}}{%
	\bib{@Mastersthesis{##1,
			title={##2},
			author={##3},
			year={##4},
			school={##5},
			##6}
		}
	}
	\NDC{\phd}{mmmmmO{}}{%
	\bib{@PhDthesis{##1,
			title={##2},
			author={##3},
			year={##4},
			school={##5},
			##3}
		}
	}
	\NDC{\misc}{mmmO{}}{%
	\bib{@Misc{##1,
			title={##2},
			author={##3},
			##4}
		}
	}
	\NDC{\proceedings}{mmmO{}}{%
	\bib{@Proceedings{##1,
			title={##2},
			year={##3},
			##4}
		}
	}
	\NDC{\report}{mmmmmO{}}{%
	\bib{@Techreport{##1,
			title={##2},
			author={##3},
			year={##4},
			institution={##5},
			##6}
		}
	}
	\NDC{\unpublished}{mmmmO{}}{%
	\bib{@Unpublished{##1,
			title={##2},
			author={##3},
			note={##4},
			##5}
		}
	}
}{%
\bibliographystyle{#1}
\bibliography{\jobname}
}

%Tikz
\newif\ifuse@tikz
\newif\ifuse@tcolorbox

\bool_if:NTF \g_tikz_bool {\use@tikztrue} {\use@tikzfalse}
\bool_if:NTF \g_tcolorbox_bool {\use@tcolorboxtrue} {\use@tcolorboxfalse}
\ExplSyntaxOff

\ifuse@tikz
	\RequirePackage{tikz, tikz-3dplot, tikz-cd}
	\usetikzlibrary{intersections, calc, positioning, patterns}
\fi

%Tcolorbox
\ifuse@tcolorbox
	\RequirePackage{tikz, tikz-3dplot, tikz-cd}
	\usetikzlibrary{intersections, calc, positioning, patterns}
	\RequirePackage[many]{tcolorbox}
\fi

%Multicolumn
\ExplSyntaxOn
\bool_if:NT \g_multicol_bool {\RequirePackage{multicol}}

\NewDocumentCommand{\begincol}{sO{2}}{%
	\bool_if:NTF \g_multicol_bool
		{%
			\IfBooleanTF{#1}
				{%
					\begin{multicols*}{#2}
					\bool_set_true:N \g_multicolumn_end_star_bool
				}
				{%
					\begin{multicols}{#2}
					\bool_set_true:N \g_multicolumn_end_bool
				}
		}
		{%
			\ClassError{coprime}{%
				Add~'multicol'~option~to~use~this~command
			}{%
				Add~'multicol'~option~to~use~this~command
			}
		}
}
\NewDocumentCommand{\endcol}{s}{%
	\bool_if:NTF \g_multicol_bool
		{%
			\IfBooleanTF{#1}
				{%
					\end{multicols*}
					\bool_set_false:N \g_multicolumn_end_star_bool
				}
				{%
					\end{multicols}
					\bool_set_false:N \g_multicolumn_end_bool
				}
		}
		{%
			\ClassError{coprime}{%
				Add~'multicol'~option~to~use~this~command
			}{%
				Add~'multicol'~option~to~use~this~command
			}
		}
}

%Ignore Badboxes
\hbadness=10000
\hfuzz=1000pt

%Theorem Style
\cs_undefine:N \definition
\cs_undefine:N \theorem
\cs_undefine:N \proposition
\cs_undefine:N \lemma
\cs_undefine:N \corollary
\cs_undefine:N \proof
\cs_undefine:N \remark
\cs_undefine:N \counterexample

\newif\ifuse@fancythm
\newif\ifuse@hyperlink
\newif\ifuse@@fancythm
\newif\if@isproved
\def\fancyon{%
\ifuse@@fancythm
\use@fancythmtrue
\else
\ClassError{coprime}{To~use~it,~you~must~add~the~fancythm~option.}{Add~the~fancythm~option}
\fi}
\def\fancyoff{%
\ifuse@@fancythm
\use@fancythmfalse
\else
\ClassError{coprime}{To~use~it,~you~must~add~the~fancythm~option.}{Add~the~fancythm~option.}
\fi}
\bool_if:NT \g_fancythm_bool
	{
		\RequirePackage[many]{tcolorbox}
		\RequirePackage{varwidth}
		\use@@fancythmtrue
	}
\bool_if:NT \g_hyperlink_bool
	{\use@hyperlinktrue}

\ExplSyntaxOff
\newlength{\thmtitlewidth}
\newlength{\thmtitlewidthtmp}
\def\@proof{\relax}
\theoremstyle{remark}
\newtheorem*{@pf}{proof}
\newtheorem*{@counter}{counterexample}
\newtheorem*{@remark}{remark}
\newtheoremstyle{named}{\topsep}{\topsep}{\itshape}{}{\bfseries}{.}{.5em}{\thmnumber{#2} \thmnote{#3}}
\theoremstyle{named}
\newtheorem{namedthm}{Theorem}[section]
\theoremstyle{plain}
	\def\do#1{%
		\newcounter{#1}[section]
		\setcounter{#1}{0}
		\@namedef{the#1}{\arabic{section}.\arabic{#1}}
		\ifuse@hyperlink
		\relax
		\else
		\crefname{#1}{\lowercase{#1}}{\lowercase{#1}}
		\Crefname{#1}{#1}{#1}
		\fi
	}
	\docsvlist{Definition,Theorem,Proposition,Corollary,Lemma}

	\NewDocumentEnvironment{defin}{o}{%
		\refstepcounter{Definition}
		\ifuse@fancythm
		\IfNoValueTF{#1}{\def\expl@in{}}{\def\expl@in{#1}}
		\par
		\settowidth{\thmtitlewidthtmp}{\expl@in}
		\addtolength{\thmtitlewidth}{1.2323\thmtitlewidthtmp}
		\settowidth{\thmtitlewidthtmp}{Definition \theDefinition}
		\addtolength{\thmtitlewidth}{1.2323\thmtitlewidthtmp}
		\addtolength{\thmtitlewidth}{16mm}
		\begin{tcolorbox}[
		enhanced,breakable,empty,
		extras unbroken and first={
		frame code = {%
		    \draw[line width=0.5mm] ([xshift=-0.25mm]frame.north east)
			-- ([xshift=-0.25mm,yshift=10.75pt]frame.north east)
			-- ([xshift=\thmtitlewidth,yshift=10.75pt]frame.north west);
			}},
		colframe=black,coltitle=white,
		colbacktitle=black,borderline west={0.5mm}{0mm}{black},
		borderline south={0.5mm}{0mm}{black},
		borderline east={0.5mm}{0mm}{black},
		attach boxed title to top left={xshift=0mm},
		left = 1em, right = 1em, top = 4pt, bottom = 4pt, before skip = 5pt,
		varwidth boxed title,boxed title style={%
			boxsep=4.5pt,
			frame code = {\path[tcb fill frame] ([yshift=-2pt]frame.north west) -- ([xshift=-1mm,yshift=-2pt]frame.north east) --
			    ([xshift=1mm]frame.east)-- ([xshift=-1mm,yshift=2pt]frame.south east) -- ([yshift=2pt]frame.south west) -- cycle;
			\path ([xshift=3mm]frame.east) node[right] {\large\bfseries\textsf{\expl@in}};}},
		title = {\large\bfseries\textsf{Definition \theDefinition}}]
		\else
		\IfNoValueTF{#1}{\def\expl@in{}}{\def\expl@in{\space({#1})}}
		\begin{flushleft}
		{\bfseries Definition \theDefinition}{\expl@in}{\bfseries .}
		\fi
	}
	{%
		\ifuse@fancythm
		\end{tcolorbox}
		\par
		\else
		\end{flushleft}
		\fi
	}

	\long\def\do#1{\NewDocumentEnvironment{#1}{o}{%
		\refstepcounter{#1}
		\let\proof\@proof
		\ifuse@fancythm
		\RenewDocumentCommand{\@proof}{O{}}{%
			\end{tcolorbox}
			\@isprovedtrue
			\begin{pf}[####1]
		}
		\let\proof\@proof
		\par
		\IfNoValueTF{##1}{\def\expl@in{}}{\def\expl@in{##1}}
		\@isprovedfalse
		\settowidth{\thmtitlewidthtmp}{\expl@in}
		\addtolength{\thmtitlewidth}{1.2323\thmtitlewidthtmp}
		\settowidth{\thmtitlewidthtmp}{#1 \csname the#1\endcsname}
		\addtolength{\thmtitlewidth}{1.2323\thmtitlewidthtmp}
		\addtolength{\thmtitlewidth}{16mm}
		\begin{tcolorbox}[enhanced,breakable,empty,
		extras unbroken and first={%
		frame code = {%
		    \draw[line width=0.5mm] ([xshift=-0.25mm]frame.north east)
			-- ([xshift=-0.25mm,yshift=10.75pt]frame.north east)
			-- ([xshift=\thmtitlewidth,yshift=10.75pt]frame.north west);
			}},
		colframe=black,coltitle=white,
		colbacktitle=black,borderline west={0.5mm}{0mm}{black},
		borderline south={0.5mm}{0mm}{black},
		borderline east={0.5mm}{0mm}{black},
		attach boxed title to top left={xshift=0mm},
		left = 1em, right = 1em, top = 4pt, bottom = 4pt, before skip = 5pt,
		varwidth boxed title,boxed title style={%
			boxsep=4.5pt,
			frame code = {\path[tcb fill frame] ([yshift=-2pt]frame.north west) -- ([xshift=-1mm,yshift=-2pt]frame.north east) --
			    ([xshift=1mm]frame.east)-- ([xshift=-1mm,yshift=2pt]frame.south east) -- ([yshift=2pt]frame.south west) -- cycle;
			\path ([xshift=3mm]frame.east) node[right] {\large\bfseries\textsf{\expl@in}};
			}
		},
		title = {\large\bfseries\textsf{#1 \csname the#1\endcsname}}]
		\else
		\IfNoValueTF{##1}{\def\expl@in{}}{\def\expl@in{\space({##1})}}
		\@isprovedfalse
		\RenewDocumentCommand{\@proof}{O{}}{%
			\endgroup
			\end{flushleft}
			\@isprovedtrue
			\begin{pf}[####1]
		}
		\let\proof\@proof
		\begin{flushleft}
		{\bfseries #1 \csname the#1\endcsname}{\expl@in}{\bfseries .}
		\begingroup
		\itshape
		\fi
	}
	{%
		\ifuse@fancythm
		\if@isproved
			\end{pf}
		\else
			\end{tcolorbox}
			\par
		\fi
		\else
		\if@isproved
			\end{pf}
		\else
		\endgroup
		\end{flushleft}
		\fi\fi
	}}
	\docsvlist{Theorem,Proposition,Corollary,Lemma}

	\NewDocumentEnvironment{pf}{O{}}{%
		\ifuse@fancythm
		\if@isproved
			\begin{tcolorbox}[breakable, blanker, width=\textwidth, top = 6pt, bottom = 6pt,
			    borderline north = {0.5mm}{0mm}{black},
			    borderline south = {0.5mm}{0mm}{black}]
		\fi
		\begin{@pf}[#1]
		\else
		\begin{@pf}[#1]
		\fi
	}
	{%
		\ifuse@fancythm
		\end{@pf}
		\if@isproved
			\end{tcolorbox}
		\fi
		\par
		\else
		\end{@pf}
		\fi
	}

	\let\remark\@remark
	\let\endremark\end@remark
	\let\counterexample\@counter
	\let\endcounterexample\end@counter


\NewDocumentEnvironment{definition}{o}{\begin{defin}[#1]}{\end{defin}}
\NewDocumentEnvironment{theorem}{o}{\begin{Theorem}[#1]}{\end{Theorem}}
\NewDocumentEnvironment{proposition}{o}{\begin{Proposition}[#1]}{\end{Proposition}}
\NewDocumentEnvironment{corollary}{o}{\begin{Corollary}[#1]}{\end{Corollary}}
\NewDocumentEnvironment{thm}{o}{\begin{Theorem}[#1]}{\end{Theorem}}
\NewDocumentEnvironment{prop}{o}{\begin{Proposition}[#1]}{\end{Proposition}}
\NewDocumentEnvironment{coro}{o}{\begin{Corollary}[#1]}{\end{Corollary}}
\NewDocumentEnvironment{lemma}{o}{\begin{Lemma}[#1]}{\end{Lemma}}
\NewDocumentEnvironment{proof}{o}{\begin{pf}[#1]}{\end{pf}}

\ExplSyntaxOn

%Font Settings
\newcommand\nano{\fontsize{0.454\font_size_dim}{1.3em}\selectfont}
\newcommand\micro{\fontsize{0.545\font_size_dim}{1.3em}\selectfont}
\renewcommand\tiny{\fontsize{0.636\font_size_dim}{1.3em}\selectfont}
\renewcommand\scriptsize{\fontsize{0.727\font_size_dim}{1.3em}\selectfont}
\renewcommand\footnotesize{\fontsize{0.818\font_size_dim}{1.3em}\selectfont}
\renewcommand\small{\fontsize{0.909\font_size_dim}{1.3em}\selectfont}
\renewcommand\normalsize{\fontsize{\font_size_dim}{1.3em}\selectfont}
\renewcommand\large{\fontsize{1.0909\font_size_dim}{1.3em}\selectfont}
\renewcommand\Large{\fontsize{1.2727\font_size_dim}{1.313em}\selectfont}
\renewcommand\LARGE{\fontsize{1.5454\font_size_dim}{1.456em}\selectfont}
\renewcommand\huge{\fontsize{1.8181\font_size_dim}{1.599em}\selectfont}
\renewcommand\Huge{\fontsize{2.2727\font_size_dim}{1.742em}\selectfont}
\newcommand\HUGE{\fontsize{2.7272\font_size_dim}{1.885em}\selectfont}
\newcommand\giant{\fontsize{2.9090\font_size_dim}{2.028em}\selectfont}
\newcommand\Giant{\fontsize{4.3636\font_size_dim}{2.171em}\selectfont}
\newcommand\GIANT{\fontsize{5.8181\font_size_dim}{2.314em}\selectfont}

\protected\def\rm#1{\ifmmode\mathrm{#1}\else\textrm{#1}\fi}
\protected\def\sf#1{\ifmmode\mathsf{#1}\else\textsf{#1}\fi}
\protected\def\tt#1{\ifmmode\mathtt{#1}\else\texttt{#1}\fi}
\protected\def\bf#1{\ifmmode\mathbf{#1}\else\textbf{#1}\fi}
\protected\def\md#1{\ifmmode\text{\mdseries #1}\else{\mdseries #1}\fi}
\protected\def\lf#1{\ifmmode\text{\lfseries #1}\else{\lfseries #1}\fi}
\protected\def\it#1{\ifmmode\text{\itshape #1}\else{\itshape #1}\fi}
\protected\def\up#1{\ifmmode\text{\upshape #1}\else{\upshape #1}\fi}
\protected\def\sl#1{\ifmmode\text{\slshape #1}\else{\slshape #1}\fi}
\protected\def\sc#1{\ifmmode\text{\scshape #1}\else{\scshape #1}\fi}

%Math Commands
\let\DMO\DeclareMathOperator
\let\largecomp\complement

\newcommand{\es}[1]{\EuScript{#1}}
\newcommand{\scr}[1]{\mathscr{#1}}
\renewcommand{\cal}[1]{\mathcal{#1}}

\fp_compare:nNnTF {\fp_use:N \c__edited_version_fp} > {-1.895} {%
\newcommand{\ds}[1]{\mathds{#1}}
\newcommand{\bbb}[1]{%
\bool_if:NTF \g_nostix_bool
	{%
		\ifx 1#1
			\ds{1}
		\else
			\mathbb{#1}
		\fi
	}
	{%
		\mathbb{#1}
	}
}
}{\newcommand{\bbb}[1]{\mathbb{#1}}}
\renewcommand{\frak}[1]{\mathfrak{#1}}

\def\do#1{%
    \@namedef{#1b}{\ensuremath{\bbb{#1}}}
    \@namedef{#1c}{\ensuremath{\mathcal{#1}}}
    \@namedef{#1s}{\ensuremath{\mathscr{#1}}}
    \@namedef{#1e}{\ensuremath{\EuScript{#1}}}
    \@namedef{#1f}{\ensuremath{\mathfrak{#1}}}
}
\docsvlist{A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z}
\let\N\Nb \let\Z\Zb \let\Q\Qb \let\R\Rb \let\@C\Cb
\newcommand{\cl}[1]{\overline{#1}}
\newcommand{\proved}{\ifmmode \tag*{$\Box$}\else\null\hfill $\Box$\fi}
\renewcommand{\complement}[1]{{#1}^{\mathsf{c}}}
\newcommand{\comp}[1]{{#1}^{\mathsf{c}}}
\newcommand{\contradiction}{\ifmmode(\downzigzagarrow)\else$(\downzigzagarrow)$\fi}

\tl_new:N \l_is_not_endmath_tl

\sys_if_engine_pdftex:T
{%
\fp_compare:nNnTF {\fp_use:N \c__edited_version_fp} > {-1.895}
	{%
		\let\oldnot\not
		\newcommand{\nulln@t}{\oldnot\null}
		\newcommand{\n@t}[1]{%
		\tl_set:Nn \l_is_not_endmath_tl {#1}
		\tl_if_in:NnTF \l_is_not_endmath_tl {^^24}
			{%
				\nulln@t^^24
			}
			{%
				\centernot{#1}
			}
		}
		\let\not\n@t
	}
	{%
		\let\oldnot\not
		\newcommand{\nulln@t}{\oldnot\null}
		\newcommand{\n@t}[1]{%
			\tl_set:Nn \l_is_not_endmath_tl {#1}
			\tl_if_in:NnTF \l_is_not_endmath_tl {^^24}
				{%
					\nulln@t^^24
				}
				{%
					\centernot{#1}
				}
		}
		\let\not\n@t
	}
}
\tl_new:N \l_change_cs_tl
\tl_new:N \l_type_matrix_tl
\fp_compare:nNnT {\fp_use:N \c__edited_version_fp} > {-1.705} {%
\NewDocumentCommand{\Matrix}{>{\ReverseBoolean}soom}{%
	\tl_set:Nn \l_change_cs_tl {#4}
	\tl_replace_all:Nnn \l_change_cs_tl {,} {&}
	\sys_if_engine_luatex:TF
	{
	    \tl_replace_all:Nnn \l_change_cs_tl {;} {\\[6pt]}
	}{
	    \tl_replace_all:Nnn \l_change_cs_tl {;} {\\}
	}
	\IfBooleanTF{#1}
	{%
		\IfNoValueTF{#2}
		{\tl_set:Nn \l_type_matrix_tl {p}}
		{%
			\tl_if_in:nnTF {#2} {n}
			{\tl_set:Nn \l_type_matrix_tl {}}
			{\tl_set:Nn \l_type_matrix_tl {#2}}
		}
		\tl_put_right:Nn \l_type_matrix_tl {matrix}
		\begin{\tl_use:N \l_type_matrix_tl}
			\tl_use:N \l_change_cs_tl
		\end{\tl_use:N \l_type_matrix_tl}
	}
	{%
	\tl_if_empty:nTF {#2}
		{\def\LeftDelimeter{(}}
		{\def\LeftDelimeter{#2}}
	\IfNoValueTF{#3}
		{\def\RightDelimeter{)}}
		{\def\RightDelimeter{#3}}
	\left\LeftDelimeter\begin{matrix}
		\tl_use:N \l_change_cs_tl
	\end{matrix}\right\RightDelimeter
	}
}}
\NewDocumentCommand{\idx}{mm}{\idx@Assist{#1,#2}}
\NewDocumentCommand{\idx@Assist}{>{\SplitArgument{4}{,}}m}{%
\idx@@Assist #1
}
\NewDocumentCommand{\idx@@Assist}{mmmmm}{%
\fourIdx{#1}{#3}{#2}{#4}{#5}
}
\NewDocumentCommand{\converge}{O{}}{%
\IfNoValueTF{#1}
{\overset{}{\rightarrow}}
{\overset{\raisebox{-1.7pt}{\scriptsize${#1}$}}{\rightarrow}}
}
\let\olddefeq\defeq
\let\defeq\coloneqq
\let\normaleq\trianglelefteq
\let\normal\vartriangleleft
\let\DMO\DeclareMathOperator

%Head and Foot
\NewDocumentCommand{\sethead}{omomomO{0.9pt}}{%
	\IfNoValueTF{#1}{%
		\def\@HA{#2}
	}{%
		\def\@HA{#1}
	}
	\ifx &#2&
		\def\@HB{\@empty}
	\else
		\def\@HB{#2}
	\fi
	\IfNoValueTF{#3}{%
		\def\@HC{#4}
	}{%
		\def\@HC{#3}
	}
	\ifx &#4&
		\def\@HD{\@empty}
	\else
		\def\@HD{#4}
	\fi
	\IfNoValueTF{#5}{%
		\def\@HE{#6}
	}{%
		\def\@HE{#5}
	}
	\ifx &#6&
		\def\@HF{\@empty}
	\else
		\def\@HF{#6}
	\fi
	\rhead[\@HE]{\@HF}
	\chead[\@HC]{\@HD}
	\lhead[\@HA]{\@HB}
	\renewcommand{\headrulewidth}{#7}
	\bool_set_true:N \g_head_edit_bool
}
\NewDocumentCommand{\setfoot}{omomomO{0pt}}{%
	\IfNoValueTF{#1}{%
		\def\@FA{#2}
	}{%
		\def\@FA{#1}
	}
	\ifx &#2&
		\def\@FB{\@empty}
	\else
		\def\@FB{#2}
	\fi
	\IfNoValueTF{#3}{%
		\def\@FC{#4}
	}{%
		\def\@FC{#3}
	}
	\ifx &#4&
		\def\@FD{\@empty}
	\else
		\def\@FD{#4}
	\fi
	\IfNoValueTF{#5}{%
		\def\@FE{#6}
	}{%
		\def\@FE{#5}
	}
	\ifx &#6&
		\def\@FF{\@empty}
	\else
		\def\@FF{#6}
	\fi
	\rfoot[\@FE]{\@FF}
	\cfoot[\@FC]{\@FD}
	\lfoot[\@FA]{\@FB}
	\renewcommand{\footrulewidth}{#7}
	\bool_set_true:N \g_foot_edit_bool
}

\NewDocumentCommand{\editheadfoot}{s}{%
	\bool_if:NTF \g_twoside_bool
		{%
			\bool_if:NTF \g_title_author_empty_bool
				{%
					\bool_if:NF \g_head_edit_bool
						{%
							\sethead[\@empty]{\textbf{\tl_use:N \title_tl}}{\@empty}[\textbf{\tl_use:N \title_tl}]{\@empty}[0mm]
						}
					\bool_if:NF \g_foot_edit_bool
						{%
							\setfoot[\textbf{\footnotesize\thepage}]{\@empty}{\@empty}[\@empty]{\textbf{\footnotesize\thepage}}
						}
				}
				{%
					\bool_if:NF \g_head_edit_bool
						{%
							\sethead[\textbf{\thepage}]{\textbf{\tl_use:N \title_tl}}{\@empty}[\textbf{\tl_use:N \title_tl}]{\textbf{\thepage}}
						}
					\bool_if:NF \g_foot_edit_bool
						{%
							\setfoot{\@empty}{\@empty}{\@empty}
						}
				}
		}
		{%
			\bool_if:NTF \g_title_author_empty_bool
				{%
					\bool_if:NF \g_head_edit_bool
						{%
							\sethead{\@empty}{\textbf{\tl_use:N \title_tl}}{\@empty}[0mm]
						}
					\bool_if:NF \g_foot_edit_bool
						{%
							\setfoot{\@empty}{\footnotesize\thepage}{\@empty}
						}
				}
				{%
					\bool_if:NF \g_head_edit_bool
						{%
							\sethead{\@empty}{\textbf{\tl_use:N \title_tl}}{\@empty}
						}
					\bool_if:NF \g_foot_edit_bool
						{%
							\setfoot{\@empty}{\footnotesize\thepage}{\@empty}
						}
				}
		}
\IfBooleanTF{#1}{\thispagestyle{fancy}}{\pagestyle{fancy}}
}

%Start coprime
\NewDocumentCommand{\setting}{smmO{\today}}{%
	\IfBooleanT{#1}{\bool_set_true:N \g_custom_titlepage_bool}
	\tl_set:Nn \title_tl {#2}
	\tl_set:Nn \author_tl {#3}
	\tl_set:Nn \date_tl {#4}
	\tl_if_empty:NTF \author_tl
		{%
			\tl_if_empty:NTF \title_tl
				{%
					\bool_set_true:N \g_title_author_empty_bool
				}
				{%
					\bool_set_false:N \g_title_author_empty_bool
				}
		}
		{%
			\bool_set_false:N \g_title_author_empty_bool
		}
}

\let\settings\setting

\newcommand{\lensetting}[3]{%
	\tl_if_blank:nF {#1}
		{%
			\fp_set:Nn \baseline_fp {#1}
		}
	\tl_if_blank:nF {#2}
		{%
			\dim_set:Nn \parindent_dim {#2}
		}
	\tl_if_blank:nF {#3}
		{%
			\dim_set:Nn \parskip_dim {#3}
		}
}

\NewDocumentCommand{\coprimeBegin}{mmmmm}{%
	\renewcommand{\baselinestretch}{#4}
	\setlength{\parindent}{#5}
	\title{\vspace*{-20pt}\bf{\textsc{\fontsize{1.3\font_size_dim}{1.2em}\selectfont #1}}
	\vspace{-7pt}}
	\author{#2}
	\date{#3}
	\editheadfoot
	\setlength{\headheight}{20pt}
	\setlength{\headsep}{15pt}
}

\RenewDocumentEnvironment{titlepage}{}{%
\setcounter{page}{0}
\thispagestyle{empty}
\def\title{\tl_use:N \title_tl}
\def\author{\tl_use:N \author_tl}
\def\date{\tl_use:N \date_tl}
}{\newpage\maketitle}

\NewDocumentCommand{\coprime}{}{%
	\bool_if:NT \g_geometry_bool
		{%
			\bool_if:NF \g_geometry_used_bool
				{%
					\ClassError{coprime}{Where~is~\protect\setgeometry\space command?}%
						{%
							Use~\protect\setgometry\space to~use~"geometry"~option.\MessageBreak
							Useage~:~\protect\setgometry{options~of~geometry~package}
						}
				}
		}
	\bool_if:NT \g_hyperlink_bool
		{%
			\bool_if:NF \g_hyperlink_used_bool
				{%
					\ClassError{coprime}{Where~is~\protect\sethyperlink\space command?}%
						{%
							Use~\protect\sethyperlink\space to~use~"hyperlink"~option.\MessageBreak
							Useage~:~\protect\sethyperlink{options~of~hyperref~package}
						}
				}
			\def\do##1{%
			\crefname{@##1}{\lowercase{##1}}{\lowercase{##1}}
			\Crefname{@##1}{##1}{##1}
			}
\docsvlist{Definition,Theorem,Proposition,Corollary,Lemma}
		}

	\coprimeBegin{\tl_use:N \title_tl}{\tl_use:N \author_tl}{\tl_use:N \date_tl}{\fp_use:N \baseline_fp}{\parindent_dim}
	\bool_if:NF \g_custom_titlepage_bool
		{%
			\bool_if:NF \g_title_author_empty_bool
				{%
					\maketitle
				}
		}
	\fontsize{\font_size_dim}{1.3em}\selectfont
	\let\oldC\C
	\let\C\@C
}

\newcommand{\EasterEgg}{%
	\int_new:N \l_EasterEgg_int
	\int_while_do:nn {\l_EasterEgg_int <= 100000}
	{
		\int_use:N \l_EasterEgg_int \space\hfill
		\int_incr:N \l_EasterEgg_int
	}
}

\fp_compare:nNnTF {\fp_use:N \c__edited_version_fp} = {pi}
	{%
			\fp_new:N \g_EasterEgg_random_fp
			\fp_set:Nn \g_EasterEgg_random_fp {randint(0,1e15)}
			\newcommand{\RANDDDDDDD}{\fp_use:N \g_EasterEgg_random_fp}
			\RequirePackage{kotex}
			\AtBeginDocument{\noindent 버전이~정확하게~$\pi$가~된~것을~축하한다.~그에~대한~보답으로~렌덤숫자~하나를~주겠다.\\[5mm]
			\begin{center}
			\sf{\giant\bfseries \RANDDDDDDD}
			\end{center}}
	}
	{}

\fp_compare:nNnTF {\fp_use:N \c__edited_version_fp} > {-2.445}
	{%
		\AtBeginDocument{\coprime}
	}
	{%
		\NewDocumentEnvironment{TTReport}{smO{\today}mO{}O{}}
		{%
			\IfBooleanTF{#1}
				{%
					\setting{#2}{#4}[]
					\lensetting{#6}{#5}
				}
				{%
					\setting{#2}{#4}[#3]
					\lensetting{#6}{#5}
				}
			\coprime
		}
		{%
			\bool_if:NT \g_multicol_bool
				{%
					\bool_if:NT \g_multicolumn_end_bool
						{%
							\end{multicols}
						}
					\bool_if:NT \g_multicolumn_end_star_bool
						{%
							\end{multicols*}
						}
				}
		}
	}

\AtEndDocument{%
	\bool_if:NT \g_multicol_bool
		{%
			\bool_if:NT \g_multicolumn_end_bool
				{%
					\end{multicols}
				}
			\bool_if:NT \g_multicolumn_end_star_bool
				{%
					\end{multicols*}
				}
		}
}
