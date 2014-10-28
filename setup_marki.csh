setenv AT_JLAB 1
source ~marki/.alias
eval `~marki/bin/addpath.pl /home/marki/bin`
setenv EDITOR emacs
unsetenv VISUAL
set autolist
set history=1000
set savehist=(1000 merge)
set histdup=erase
set prompt="%m:%n:%C> "  # prompt set to machine:user:current directory
setenv HDSVN https://halldsvn.jlab.org/repos
setenv P12SVN https://phys12svn.jlab.org/repos
