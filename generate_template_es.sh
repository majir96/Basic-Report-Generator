#!/bin/bash


directory=""
number=0
title="informe"

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
    echo "Uso: $0 -d [STRING] -n [NUMBER] [-t TITLE] [-h]"
    echo "  -d [STRING]   Directorio (obligatorio)"
    echo "  -n [NUMBER]   Número de secciones (obligatorio)"
    echo "  -t [TITLE]    Título del documento (opcional, por defecto 'informe')"
    echo "  -h            Mostrar este mensaje de ayuda"
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
            echo "Opción inválida: -$OPTARG" >&2
            usage
            ;;
        :)
            echo "La opción -$OPTARG requiere un argumento." >&2
            usage
            ;;
    esac
done

if [ -z "$directory" ] || [ -z "$number" ]; then
    echo "Las opciones -d y -n son obligatorias." >&2
    usage
fi

banner

echo -e "\n[+] Creando directorios...\n"
sleep 0.2
mkdir -p "$directory/images" "$directory/secciones"
echo -e "\n[+] Creando secciones...\n"
sleep 0.2 
for i in $(seq 1 $number); do touch "$directory/secciones/seccion$i.tex"; done 
echo -e "\n[+] Creando plantilla...\n"

template_file="$directory/$title.tex"

cat <<EOT > "$template_file"
\documentclass[a4paper,12pt]{article}
\usepackage[utf8]{inputenc}
\usepackage[spanish]{babel}
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

\renewcommand{\lstlistingname}{Código}
\addto\captionsspanish{\renewcommand{\tablename}{Tabla}}

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
    echo "\\input{secciones/seccion$i.tex}" >> "$template_file"
    echo >> "$template_file"
done

echo "\end{document}" >> "$template_file"

echo -e "\n[+] Plantilla LaTeX creada en: $template_file\n"
echo -e "\n[+] Número de secciones generadas: $number"
echo -e "\n[+] Archivo principal con nombre: $title.tex\n"
