{ pkgs ? (import <nixpkgs> {}) }:

let
  env = with pkgs.haskellPackages; [
    pandoc
    pandoc-citeproc
    pandoc-crossref

    (pkgs.texlive.combine {
      inherit (pkgs.texlive)
        scheme-small
        algorithms
        cm-super
        collection-basic
        collection-bibtexextra
        collection-fontsextra
        collection-fontutils
        collection-langenglish
        collection-langgerman
        collection-latex
        collection-latexextra
        collection-latexrecommended
        collection-mathextra
        collection-metapost
        collection-pictures
        collection-plainextra
        collection-science
      ;
    })

    pkgs.lmodern
  ];

  pandoc-filter = pkgs.buildPythonPackage rec {
    version = "1.3.0";
    name = "pandoc-filters-${version}";

    src = pkgs.fetchurl {
      url = "https://github.com/jgm/pandocfilters/archive/${version}.tar.gz";
      sha256 = "1sgd0h5jwk7l1r33s5hwcg4j3zs5l3059p8wdcaqy0sqvhwd06il";
    };

    propagatedBuildInputs = with pkgs; [ python ];
  };

  pygraphviz = pkgs.pythonPackages.buildPythonPackage rec {
    version = "1.2";
    name = "pygraphviz-${version}";

    src = pkgs.fetchurl {
      url = "https://github.com/pygraphviz/pygraphviz/archive/${name}.tar.gz";
      sha256 = "0jyd049wj994y1h9k3xwvjk9jwzi6vpdj10767kq8alz86hp4ak5";
    };

    propagatedBuildInputs = [ pkgs.graphviz pkgs.pkgconfig ];

  };

  blockdiag = pkgs.pythonPackages.buildPythonPackage rec {
    version = "1.5.3";
    name = "blockdiag-${version}";

    src = pkgs.fetchurl {
      url = "https://pypi.python.org/packages/source/b/blockdiag/${name}.tar.gz";
      sha256 = "12xfh1j0z346lkx23q0901hln3kmfyhlqvycrjx0z90cr8gm18sy";
    };

    propagatedBuildInputs = with pkgs.pythonPackages; [
        funcparserlib
        webcolors
        pillow
        docutils
        reportlab
        pep8
        mock
        nose
    ];

    doCheck = false;

  };

  seqdiag = pkgs.pythonPackages.buildPythonPackage rec {
    version = "0.9.5";
    name = "seqdiag-${version}";

    src = pkgs.fetchurl {
      url = "https://pypi.python.org/packages/source/s/seqdiag/${name}.tar.gz";
      sha256 = "0mr6fk3y4i5vw85r0pys7iar0wks76m1126i2ghpxxzy375h4i4r";
    };

    propagatedBuildInputs = with pkgs.pythonPackages; [
        funcparserlib
        pillow
        blockdiag
    ];

    doCheck = false;

  };

  actdiag = pkgs.pythonPackages.buildPythonPackage rec {
    version = "0.5.4";
    name = "actdiag-${version}";

    src = pkgs.fetchurl {
      url = "https://pypi.python.org/packages/source/a/actdiag/${name}.tar.gz";
      sha256 = "1bs6mcas8z1k3zflq9ms5f6sra4qq5kizgpkmqx0jhcrgmvp2c4q";
    };

    propagatedBuildInputs = with pkgs.pythonPackages; [
        funcparserlib
        pillow
        reportlab
        blockdiag
    ];

    doCheck = false;

  };

  nwdiag = pkgs.pythonPackages.buildPythonPackage rec {
    version = "1.0.4";
    name = "nwdiag-${version}";

    src = pkgs.fetchurl {
      url = "https://pypi.python.org/packages/source/n/nwdiag/${name}.tar.gz";
      sha256 = "1yhk4bf4pp4vh3a7ipvw7yf2ci6zmc3qqmszzhnrly2ran3na980";
    };

    propagatedBuildInputs = with pkgs.pythonPackages; [
        funcparserlib
        pillow
        reportlab
        blockdiag
    ];

    doCheck = false;

  };

in
pkgs.stdenv.mkDerivation rec {
    name = "paper";
    src = ./.;
    version = "0.0.0";

    buildInputs = [
      env
      pandoc-filter
      pygraphviz
      pkgs.mscgen
      blockdiag
      seqdiag
      actdiag
      nwdiag
      pkgs.R
      pkgs.plantuml
      pkgs.biber
    ];

}

