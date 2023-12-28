(lang dune 3.12)

(using melange 0.1)

(generate_opam_files)

(name re-formality)

(source
 (github shakacode/re-formality))

(license MIT)

(maintainers "Unmaintained")

(authors "Alex Fedoseev")

(homepage https://github.com/shakacode/re-formality)

(bug_reports https://github.com/shakacode/re-formality/issues)

(package
 (name re-formality)
 (synopsis "Form validation tool for reason-react")
 (description "Form validation tool for reason-react")
 (depends
  dot-merlin-reader
  (melange
   (>= 2.0.0))
  (ocaml
   (>= 5.1.0))
  (reason
   (>= 3.10.0))
  ocaml-lsp-server
  ocamlformat
  opam-check-npm-deps
  alcotest
  reason-react
  re-debouncer
  ppxlib))
