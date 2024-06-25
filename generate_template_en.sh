#!/bin/bash

# Initialize variables
directory=""
number=0
title="report"

## Banner 
banner() {
    echo "###############################################"
    echo "#                                             #"
    echo "#              Made by majir96                #"
    echo "#          Licensed under GPL v3.0            #"
    echo "#                                             #"
    echo "###############################################"
}

## Help
usage() {
    echo "Usage: $0 -d [STRING] -n [NUMBER] [-t TITLE] [-h]"
    echo "  -d [STRING]   Directory (required)"
    echo "  -n [NUMBER]   Number of sections (required)"
    echo "  -t [TITLE]    Document title (optional, default 'report')"
    echo "  -h            Show this help message"
    exit 1
}

## Parser
while getopts ":d:n:t:h" opt; do
    case $opt in
        d)
            directory=$OPTARG
            ;;
        n)
            number=$OPTARG
            ;;
        t)
            title=$OPTARG
            ;;
        h)
            usage
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            usage
            ;;
        :)
            echo "Option -$OPTARG requires an argument." >&2
            usage
            ;;
    esac
done

if [ -z "$directory" ] || [ -z "$number" ]; then
    echo "Options -d and -n are required." >&2
    usage
fi

banner

echo -e "\n[+] Creating directories...\n"
sleep 0.2
mkdir -p "$directory/images" "$directory/sections"
echo -e "\n[+] Creating sections...\n"
sleep 0.2 
for i in $(seq 1 $number); do touch "$directory/sections/section$i.tex"; done 
echo -e "\n[+] Creating template...\n"

template_file="$directory/$title.tex"

cat <<EOT > "$template_file"
\documentclass[a4paper,12pt]{article}
\usepackage[utf8]{inputenc}
\usepackage[english]{babel}
\usepackage{graphicx}
\usepackage{xcolor}
\usepackage{listings}
\usepackage{verbatim}
\usepackage{hyperref}
\usepackage{float}
\usepackage{amsmath}
\usepackage{amsfonts}
\usepackage{amssymb}
\usepackage{subcaption}
\definecolor{codegreen}{rgb}{0,0.6,0}
\definecolor{codegray}{rgb}{0.5,0.5,0.5}
\definecolor{codepurple}{rgb}{0.58,0,0.82}
\definecolor{backcolour}{rgb}{0.95,0.95,0.92}
\definecolor{darkblue}{rgb}{0, 0, 0.5}

\hypersetup{
    colorlinks=true,
    linkcolor=darkblue,
    filecolor=magenta,
    urlcolor=darkblue,
}

\renewcommand{\lstlistingname}{Code}
\addto\captionsenglish{\renewcommand{\tablename}{Table}}

\lstdefinestyle{nmapstyle}{
    backgroundcolor=\color{lightgray},
    basicstyle=\ttfamily\scriptsize,
    commentstyle=\color{gray},
    keywordstyle=\color{blue}\bfseries,
    numberstyle=\tiny\color{gray},
    stringstyle=\color{orange},
    frame=single,
    rulecolor=\color{black},
    breaklines=true,
    postbreak=\mbox{\textcolor{red}{$\hookrightarrow$}\space},
    numbers=left,
    numbersep=5pt,
    xleftmargin=10pt,
}

\lstdefinestyle{htmlstyle}{
    backgroundcolor=\color{backcolour},
    commentstyle=\color{codegreen},
    keywordstyle=\color{magenta},
    numberstyle=\tiny\color{codegray},
    stringstyle=\color{codepurple},
    basicstyle=\ttfamily\scriptsize,
    breakatwhitespace=false,
    breaklines=true,
    captionpos=b,
    keepspaces=true,
    numbers=left,
    numbersep=5pt,
    showspaces=false,
    showstringspaces=false,
    showtabs=false,
    tabsize=2,
    language=HTML
}

\lstdefinestyle{phpphp}{
    backgroundcolor=\color{backcolour},   
    commentstyle=\color{codegreen},
    keywordstyle=\color{magenta},
    numberstyle=\tiny\color{codegray},
    stringstyle=\color{codepurple},
    basicstyle=\ttfamily\scriptsize,
    breakatwhitespace=false,         
    breaklines=true,                 
    captionpos=b,                    
    keepspaces=true,                 
    numbers=left,                    
    numbersep=5pt,                  
    showspaces=false,                
    showstringspaces=false,
    showtabs=false,                  
    tabsize=2,
    language=PHP
}

\lstdefinestyle{pythonstyle}{
    backgroundcolor=\color{backcolour},
    commentstyle=\color{codegreen},
    keywordstyle=\color{blue},
    numberstyle=\tiny\color{codegray},
    stringstyle=\color{codepurple},
    basicstyle=\ttfamily\scriptsize,
    breakatwhitespace=false,
    breaklines=true,
    captionpos=b,
    keepspaces=true,
    numbers=left,
    numbersep=5pt,
    showspaces=false,
    showstringspaces=false,
    showtabs=false,
    tabsize=2,
    language=Python
}

\lstdefinestyle{javascriptstyle}{
    backgroundcolor=\color{backcolour},
    commentstyle=\color{codegreen},
    keywordstyle=\color{magenta},
    numberstyle=\tiny\color{codegray},
    stringstyle=\color{codepurple},
    basicstyle=\ttfamily\scriptsize,
    breakatwhitespace=false,
    breaklines=true,
    captionpos=b,
    keepspaces=true,
    numbers=left,
    numbersep=5pt,
    showspaces=false,
    showstringspaces=false,
    showtabs=false,
    tabsize=2,
    language=JavaScript
}

\lstdefinestyle{bashstyle}{
    backgroundcolor=\color{backcolour},
    commentstyle=\color{codegreen},
    keywordstyle=\color{blue},
    numberstyle=\tiny\color{codegray},
    stringstyle=\color{codepurple},
    basicstyle=\ttfamily\scriptsize,
    breakatwhitespace=false,
    breaklines=true,
    captionpos=b,
    keepspaces=true,
    numbers=left,
    numbersep=5pt,
    showspaces=false,
    showstringspaces=false,
    showtabs=false,
    tabsize=2,
    language=bash
}

\title{$title}
\author{TODO}

\begin{document}

\maketitle
\newpage
\tableofcontents
\newpage

EOT

for i in $(seq 1 $number); do
    echo "\\input{sections/section$i}" >> "$template_file"
    echo >> "$template_file"
done

echo "\end{document}" >> "$template_file"

echo -e "\n[+] LaTeX template created at: $template_file\n"
echo -e "\n[+] Number of sections generated: $number"
echo -e "\n[+] Main file name: $title.tex\n"
