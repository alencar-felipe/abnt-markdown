FROM archlinux

RUN pacman --noconfirm -Sy wget pandoc texlive-most python python-pip

RUN pip install pandoc-fignos pandoc-eqnos pandoc-tablenos pandoc-secnos

RUN mkdir -p /template

ADD ./template/ /template/

RUN mkdir -p /doc

WORKDIR /doc

CMD pandoc --citeproc --bibliography=foo.bib               \
 --csl /template/abnt.csl --template=/template/template.tex \
 --lua-filter=/template/filter.lua -o out.pdf doc.md     