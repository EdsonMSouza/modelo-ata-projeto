\ProvidesClass{ata}[2019/12/03 version 1.10 Ata de Reuniao] 
\NeedsTeXFormat{LaTeX2e}
\newcommand{\projeto}[1]{\def\@projeto{#1}}
\newcommand{\show@projeto}{\@projeto}
\newcommand{\curso}[1]{\def\@curso{#1}}
\newcommand{\show@curso}{\@curso}
\RequirePackage{etoolbox}
\RequirePackage{xifthen}
\RequirePackage{xargs}
\newcommand{\listadepresentes}{}
\newcommand{\listadeausentes}{}
\newcommandx*\participante[3][2=presente,3=nada,usedefault]{
  \ifthenelse{\equal{#2}{presente}}{
    \ifdefempty{\listadepresentes}%
      {\eappto\listadepresentes{#1}}%
      {\eappto\listadepresentes{, #1}}%
    \csdef{participantespresentes}{\listadepresentes}%
    }%else
    {
    \ifdefempty{\listadeausentes}%
     {
       \ifthenelse{\equal{#3}{nada}}%
       {\eappto\listadeausentes{#1}}%
       {\eappto\listadeausentes{#1 (#3)}}%
     }%else
     {%
       \ifthenelse{\equal{#3}{nada}}%
       {\eappto\listadeausentes{, #1}}%
       {\eappto\listadeausentes{, #1 (#3)}}%
     }%
    \csdef{participantesausentes}{\listadeausentes}%
    }
}

\newcommand{\papel}[2]{#1 (#2)}
\newcommand{\lider}[1]{\papel{#1}{Líder}}
\newcommand{\membro}[1]{\papel{#1}{Membro}}
\newcommand{\justificativa}[2]{#1 (#2)}
\newcommand{\capacitacao}[1]{\justificativa{#1}{justificado -- capacitação}}
\newcommand{\aula}[1]{\justificativa{#1}{justificado -- em aula}}
\global\let\@presentes\@empty
\newcommand{\listapresentes}[1]{\def\@presentes{#1}}
\newcommand{\show@presentes}{\@presentes}
\global\let\@ausentes\@empty
\newcommand{\listaausentes}[1]{\def\@ausentes{#1}}
\let\ausentes\listaausentes %
\newcommand{\show@ausentes}{\@ausentes}

% convidados
\global\let\@convidados\@empty
\newcommand{\listaconvidados}[1]{\def\@convidados{#1}}
\let\convidados\listaconvidados %
\newcommand{\show@convidados}{\@convidados}

% quem são os membros? 
\global\let\@membros\@empty
\newcommand{\listamembros}[1]{\def\@membros{#1}}
\let\membros\listamembros %
\newcommand{\show@membros}{\@membros}

% what day is it?
\def\@date{\today}
\newcommand{\setdate}[1]{\def\@date{#1}}
\newcommand{\show@date}{\@date}

% --- Class structure: declaration of options part
% ---
% This class extends the article class
% Read all the documentclass options; pass them to article
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}

% --- Class structure: execution of options part
% ---
\ProcessOptions \relax

% --- Class structure: declaration of options part
% ---
\LoadClass{article}


% Codificação de caracteres
\RequirePackage[utf8]{inputenc}


% --- Class structure: main code part
% ---

\newcommand{\lista@membros}{
\ifthenelse{\equal{\listadepresentes}{}}{
% Esse bloco é só para manter compatibilidade com código legado da versão 1.00 dessa classe.
% Poderia ser substituído por \relax
\ifx\@presentes\@empty
  \relax
\else
\noindent
\textbf{Presentes:} \show@presentes.
\fi
% ---- Fim do bloco legado -------- %
}{%
\noindent
\textbf{Presentes:} \csuse{participantespresentes}.%
}
\ifthenelse{\equal{\listadeausentes}{}}{
% Esse bloco é só para manter compatibilidade com código legado da versão 1.00 dessa classe.
% Poderia ser substituído por \relax
\ifx\@ausentes\@empty
  \relax
\else
\noindent
\textbf{Ausentes:} \show@ausentes.
\fi %  
% ---- Fim do bloco legado -------- %
}{%
\noindent\\
\textbf{Ausentes:} \csuse{participantesausentes}.
}
\ifx\@convidados\@empty
  \relax
\else

\noindent
\textbf{Convidados:} \show@convidados.
\fi %
\vspace{1ex}
}

\newenvironment{reuniao}[1]{%
\begin{center}
  {\Large\textbf{ATA DA REUNIÃO #1}}\\[1ex]
  {\large\textbf{\show@projeto}}\\[1ex]
  {\large\textbf{\show@curso}}\\[1ex]
  \show@date
\end{center}
\vspace{1.5ex}
}{%
\lista@membros
\vspace{1ex}
}

\newenvironment{businesslist}[1]{%
\vspace{2ex}\par\noindent\textbf{#1}\par
\begin{enumerate}
}{%
\end{enumerate}
}

\newenvironment{assuntos}{%
\begin{businesslist}{Assuntos}
}{%
\end{businesslist}
}

\newenvironment{informes}{%
\begin{businesslist}{Informes}
}{%
\end{businesslist}
}

% % when is the next meeting?
\newcommand{\proximareuniao}[1]{%
\par\noindent\textbf{Próxima reunião:} #1\par
}

% % OK the minutes of the last meeting
\newcommand{\aprovada}{A ATA da reunião passada foi aprovada. }

% Para hachurar partes confidenciais
\RequirePackage{censor}


% Page layout
\RequirePackage[a4paper,hmargin=2.3cm,top=3.5cm,bottom=2cm,headheight=3cm,heightrounded]{geometry}

\RequirePackage{lastpage}

\RequirePackage{fancyhdr}


\fancypagestyle{firstpage}{%
  \fancyhf{} % clear all six fields
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}
  \fancyhead[C]{\pgfuseimage{logo}}
  \fancyfoot[R]{página \thepage~de \pageref{LastPage}}
}

\fancypagestyle{followingpage}{%
  \fancyhf{} % clear all six fields
  \fancyhead[RE,LO]{\begin{tiny}\textsc{\show@projeto}\end{tiny}}
  \renewcommand{\headrulewidth}{.4pt}
  \renewcommand{\footrulewidth}{0pt}
  \fancyfoot[R]{\begin{small}página \thepage~de \pageref{LastPage}\end{small}}
}

\pagestyle{followingpage}
\AtBeginDocument{\thispagestyle{firstpage}}