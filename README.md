# LaTeX Template Generator

This repository contains two versions of a script to generate LaTeX document templates with customizable options for directory, number of sections, document title, image for the cover, and indices. The scripts are available in both Spanish and English.

## Scripts

- `generate_template_es.sh`: Script in Spanish.
- `generate_template_en.sh`: Script in English.

## Features

- Create a specified directory structure.
- Generate a specified number of section files.
- Create a LaTeX template document with a customizable title.
- Optionally include an image on the cover page.
- Optionally include indices for tables, images, and code listings.
- Display a banner with the author's information and GPL license notice.

## Directory Structure
The scripts create the following directory structure:

```
<directory>/
├── images/
│└── logo.<image_extension> (if image is provided)
├── <title>.tex
└── secciones/
    ├── seccion1.tex
    ├── seccion2.tex
    ├── seccion3.tex
    ├── seccion4.tex
    └── seccion5.tex
```

## Usage

### Spanish Version: `generate_template_es.sh`

This script generates a LaTeX template with options in Spanish.

#### Options

- `-d [STRING]`: Directorio (obligatorio)
- `-n [NUMBER]`: Número de secciones (obligatorio)
- `-t [TITLE]`: Título del documento (opcional, por defecto 'informe')
- `-i [IMAGE_PATH]`: Ruta a la imagen para incluir en la portada (opcional)
- `--index [all|images|code|tables]`: Incluir índices de tablas, imágenes o listados de código (opcional)
- `-h`: Mostrar el mensaje de ayuda

#### Example

```sh
./generate_template_es.sh -d mi_directorio -n 5 -t "MiTitulo" -i "ruta/a/imagen.png" --index all
```

### English Version: `generate_template_en.sh`

This script generates a LaTeX template with options in English.

#### Options

- `-d [STRING]`: Directory (required)
- `-n [NUMBER]`: Number of sections (required)
- `-t [TITLE]`: Document title (optional, default 'report')
- `-i [IMAGE_PATH]`: Path to image to include in the cover (optional)
- `--index [all|images|code|tables]`: Include indices for tables, images, or code listings (optional)
- `-h`: Show this help message
- 
#### Example
```sh
./generate_template_en.sh -d my_directory -n 5 -t "MyTitle" -i "path/to/image.png" --index all
```

----
# License and Contributions

**This project is licensed under the GNU General Public License v3.0 (GPL-3.0). You are free to use, modify, and distribute this software under the terms of the GPL-3.0 license. For more details, see the [[LICENSE]] file.**

Contributions from the community are welcomed! If you would like to contribute, you can:

- Fork the repository.
- Create a new branch for your feature or bug fix.
- Commit your changes.
- Open a pull request with a detailed description of your changes.
- Feel free to open issues if you encounter any problems or have suggestions for improvements.

**By contributing to this project, you agree to license your contributions under the GPL-3.0 license.**


