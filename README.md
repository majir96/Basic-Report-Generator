# Basic-Report-Generator
Basic LaTeX report generator written in bash 
---

# LaTeX Template Generator
This repository contains two versions of a script to generate LaTeX document templates with customizable options for directory, number of sections, and document title. The scripts are available in both Spanish and English.

## Scripts

generate_template_es.sh: Script in Spanish.
generate_template_en.sh: Script in English.

Features
Create a specified directory structure.
Generate a specified number of section files.
Create a LaTeX template document with a customizable title.
Display a banner with author's information and GPL license notice.
Usage
Spanish Version: generate_template_es.sh
This script generates a LaTeX template with options in Spanish.

Options:
-d [STRING]: Directorio (obligatorio)
-n [NUMBER]: Número de secciones (obligatorio)
-t [TITLE]: Título del documento (opcional, por defecto 'informe')
-h: Mostrar el mensaje de ayuda
Example
sh
Copiar código
./generate_template_es.sh -d mi_directorio -n 5 -t "MiTitulo"
English Version: generate_template_en.sh
This script generates a LaTeX template with options in English.

Options
-d [STRING]: Directory (required)
-n [NUMBER]: Number of sections (required)
-t [TITLE]: Document title (optional, default 'report')
-h: Show this help message
