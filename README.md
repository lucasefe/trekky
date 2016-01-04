Deprecated
==========
Use [https://middlemanapp.com/](https://middlemanapp.com/) Makes no sense to maintain it. 

trekky
======

Simple, very simple, sass and haml compiler for dear designer friend. 

## Features

Say you have a file structure like this:

    source
    ├── images
    │   └── image.jpg
    ├── index.html.haml
    ├── javascripts
    │   └── app.js
    ├── layouts
    │   └── default.haml
    └── stylesheets
        └── hola.css.sass
  
And you run: 

    trekky -s source -t public
    
You'll end up having this:

    public
    ├── images
    │   └── image.jpg
    ├── index.html
    ├── javascripts
    │   └── app.js
    └── stylesheets
        └── hola.css

## HELP

    trekky  -h
    usage: trekky [-h] [-s source] [-t target]


## Deamon mode

Monitors source dir for changes, and copy/process on demand to target dir. 
    
    trekky -d
    
