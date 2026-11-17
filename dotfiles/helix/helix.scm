(require "helix/misc.scm")

(provide hello-world)
(require (only-in "go.hx/cogs/go-hx.scm" go-test go-test-annotate go-test-clear))

(provide go-test go-test-annotate go-test-clear)

;;@doc
;; Print hello world in the statusline.
(define (hello-world)
  (set-status! "hello world"))
(require (only-in "strcase.hx/init.scm"
                  strcase-snake
                  strcase-kebab
                  strcase-camel
                  strcase-pascal
                  strcase-screaming-snake
                  strcase-title
                  strcase-smart-case-upper
                  strcase-smart-case-lower))

(provide strcase-snake
         strcase-kebab
         strcase-camel
         strcase-pascal
         strcase-screaming-snake
         strcase-title
         strcase-smart-case-upper
         strcase-smart-case-lower)
