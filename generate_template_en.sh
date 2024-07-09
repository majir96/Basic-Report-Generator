#!/bin/bash

#Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

## Global variables
directory=""
number=0
title="report"
image=""
index_options=""

ctrl_c() {
  echo -e "${redColour}\n[!] Interruption detected. Forcing exit...${endColour}"
  exit 1
}

# SIGINT 
trap ctrl_c SIGINT 

## Banner 
banner() {
    echo -e "${blueColour}###############################################${endColour}"
    echo -e "${blueColour}#                                             #${endColour}"
    echo -e "${blueColour}#              Made by majir96                #${endColour}"
    echo -e "${blueColour}#          Licensed under GPL v3.0            #${endColour}"
    echo -e "${blueColour}#                                             #${endColour}"
    echo -e "${blueColour}###############################################${endColour}"
}

## Help
usage() {
    echo -e "${purpleColour}Usage: $0 -d [STRING] -n [NUMBER] [-t TITLE] -i [PATH] [--index OPTION] [-h]${endColour}"
    echo -e "${yellowColour}  -d [STRING]                       Directory (required)${endColour}"
    echo -e "${yellowColour}  -n [NUMBER]                       Number of sections (required)${endColour}"
    echo -e "${yellowColour}  -t [TITLE]                        Document title (optional, default 'report')${endColour}"
    echo -e "${yellowColour}  -i [IMAGE_PATH]                   Path to image to include in the cover (optional)${endColour}"
    echo -e "${yellowColour}  --index [all|images|code|tables]  Include indices of tables, images, or code listings (optional)${endColour}"
    echo -e "${yellowColour}  -h                                Show this help message${endColour}"
    exit 1
}

## Parser
while getopts ":d:n:t:i:-:h" opt; do
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
        i) 
            image=$OPTARG
            ;;
        -) case $OPTARG in 
            index) 
                index_option="${!OPTIND}"; OPTIND=$(( $OPTIND + 1 ))
                ;;
            *)
                echo -e "${redColour}Invalid option: --$OPTARG${endColour}" >&2                    
                usage
                    ;;
            esac
            ;; 

        h)
            usage
            ;;
        \?)
            echo -e "${redColour}Invalid option: --$OPTARG${endColour}" >&2
            usage
            ;;
        :)
            echo -e "${redColour}Option -$OPTARG requires an argument.${endColour}" >&2
            usage
            ;;
    esac
done

if [ -z "$directory" ] || [ -z "$number" ]; then
     echo -e "${redColour}Options -d and -n are required.${endColour}" >&2
     usage
fi

banner

echo -e "\n${greenColour}[+] Creating directories...${endColour}\n"
sleep 0.2
mkdir -p "$directory/images" "$directory/sections"

echo -e "\n${greenColour}[+] Creating sections...${endColour}\n"
sleep 0.2 

for i in $(seq 1 $number); do 
  section_file="$directory/sections/section$i.tex" 
  touch "$section_file"
  echo "\section{TODO}" > "$section_file"
  echo "\label{sec:TODO}" >> "$section_file"
done 

echo -e "\n${greenColour}[+] Creating template...${endColour}\n"

if [ -n "$image" ]; then
    if [ ! -f "$image" ]; then
        echo -e "${redColour}The image file '$image' does not exist.${endColour}" >&2
        exit 1
    else
        image_extension="${image##*.}"
        cp "$image" "$directory/images/logo.$image_extension"
        image="images/logo.$image_extension"
    fi
fi

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
\usepackage{hyperref}
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

EOT

# Add logo 
if [ -n "$image" ]; then
    cat <<EOT >> "$template_file"
\begin{figure}[H]
    \centering
    \includegraphics[width=0.8\textwidth]{$image}
    %\caption{Add description if you want}
    \label{fig:logo}
\end{figure}

EOT
fi

## Add index 
cat <<EOT >> "$template_file"
\newpage
\tableofcontents
\newpage
EOT

# Add list of images
if [[ "$index_option" == "all" || "$index_option" == "images" ]]; then
    cat <<EOT >> "$template_file"

\renewcommand{\listfigurename}{List of Figures}

\listoffigures
\newpage
EOT
fi

# Add list of tables
if [[ "$index_option" == "all" || "$index_option" == "tables" ]]; then
    cat <<EOT >> "$template_file"
\renewcommand{\listtablename}{List of Tables}

\listoftables
\newpage
EOT
fi

# Add list of listings
if [[ "$index_option" == "all" || "$index_option" == "code" ]]; then
    cat <<EOT >> "$template_file"
\renewcommand{\lstlistlistingname}{List of Codes}
\newcommand{\listoflistings}{\lstlistoflistings}
\lstlistoflistings
\newpage
EOT
fi

for i in $(seq 1 $number); do
    echo "\\input{sections/section$i.tex}" >> "$template_file"
    echo >> "$template_file"
done

echo "\end{document}" >> "$template_file"

echo -e "\n${greenColour}[+] LaTeX template created at: $template_file${endColour}\n"
echo -e "\n${greenColour}[+] Number of sections generated: $number${endColour}"
echo -e "\n${greenColour}[+] Main file name: $title.tex${endColour}\n"
