;;; -*- coding: utf-8-unix -*-
;;;
;;;Part of: Vicare
;;;Contents: unsafe operations
;;;Date: Sun Oct 23, 2011
;;;
;;;Abstract
;;;
;;;	This library is both  installed and used when expanding Vicare's
;;;	own source code.  For this  reason it must export only: bindings
;;;	imported  by Vicare itself,  syntaxes whose  expansion reference
;;;	only bindings imported by Vicare itself.
;;;
;;;	  In general: all the syntaxes must be used with arguments which
;;;	can be evaluated  multiple times, in practice it  is safe to use
;;;	the syntaxes  only with arguments being  identifiers or constant
;;;	values.
;;;
;;;Endianness handling
;;;
;;;	About endianness, according to R6RS:
;;;
;;;	   Endianness describes the encoding of exact integer objects as
;;;	   several contiguous bytes in a bytevector.
;;;
;;;        The little-endian encoding  places the least significant byte
;;;        of  an  integer first,  with  the  other  bytes following  in
;;;        increasing order of significance.
;;;
;;;        The big-endian  encoding places the most  significant byte of
;;;        an  integer   first,  with  the  other   bytes  following  in
;;;        decreasing order of significance.
;;;
;;;
;;;Copyright (C) 2011-2013 Marco Maggi <marco.maggi-ipsu@poste.it>
;;;
;;;This program is free software:  you can redistribute it and/or modify
;;;it under the terms of the  GNU General Public License as published by
;;;the Free Software Foundation, either version 3 of the License, or (at
;;;your option) any later version.
;;;
;;;This program is  distributed in the hope that it  will be useful, but
;;;WITHOUT  ANY   WARRANTY;  without   even  the  implied   warranty  of
;;;MERCHANTABILITY  or FITNESS FOR  A PARTICULAR  PURPOSE.  See  the GNU
;;;General Public License for more details.
;;;
;;;You should  have received  a copy of  the GNU General  Public License
;;;along with this program.  If not, see <http://www.gnu.org/licenses/>.
;;;


#!r6rs
(library (vicare unsafe operations)
  (export
    $make-struct
    $struct
    $struct-rtd
    $struct/rtd?
    $struct-length
    $struct-ref
    $struct-set!

;;; --------------------------------------------------------------------

    $fxzero?
    $fxnegative?
    $fxpositive?
    $fxnonpositive?
    $fxnonnegative?
    $fxodd?
    $fxeven?
    $fxsign
    $fxabs
    $fxadd1	;increment
    $fxsub1	;decrement
    $fxneg	;negation
    $fxsra	;shift right
    $fxsll	;shift left
    $fxlogor	;inclusive logic OR
    $fxlogxor	;exlusive logic OR
    $fxlogand	;logic AND
    $fxlognot	;logic not
    $fx+
    $fx-
    $fx*
    $fxdiv
    $fxdiv0
    $fxmod
    $fxmod0
    $fxdiv-and-mod
    $fxdiv0-and-mod0
    $fx<	;multiple arguments
    $fx>	;multiple arguments
    $fx>=	;multiple arguments
    $fx<=	;multiple arguments
    $fx=	;multiple arguments

    $fxand	;multiple arguments AND
    $fxior	;multiple arguments inclusive OR
    $fxxor	;multiple arguments exclusive OR
    $fxmax	;multiple arguments max
    $fxadd2
    $fxadd3
    $fxadd4
    $fxincr!
    $fxdecr!

;;; --------------------------------------------------------------------

    $bignum-positive?
    $bignum-negative?
    $bignum-non-positive?
    $bignum-non-negative?
    $bignum-byte-ref
    $bignum-size

    $bnbn=
    $bnbn<
    $bnbn>
    $bnbn<=
    $bnbn>=

;;; --------------------------------------------------------------------

    $make-ratnum
    $ratnum-n
    $ratnum-d
    $ratnum-num
    $ratnum-den
    $ratnum-positive?
    $ratnum-negative?
    $ratnum-non-positive?
    $ratnum-non-negative?

;;; --------------------------------------------------------------------

    $make-flonum
    $flonum-u8-ref
    $flonum-set!
    $fixnum->flonum
    $fixnum->string
    $fixnum->char
    $flonum->exact
    $flonum-integer?
    $flonum-rational?
    $fl+
    $fl-
    $fl*
    $fl/
    $fl=
    $fl<
    $fl>
    $fl<=
    $fl>=
    $flonum-sbe
    $flzero?
    $flzero?/positive
    $flzero?/negative
    $flpositive?
    $flnegative?
    $flnonpositive?
    $flnonnegative?
    $flodd?
    $fleven?
    $flnan?
    $flfinite?
    $flinfinite?

    $flround
    $flfloor
    $flceiling
    $fltruncate

    $flnumerator
    $fldenominator

    $flmax
    $flmin

    $flabs
    $flsin
    $flcos
    $fltan
    $flasin
    $flacos
    $flatan		$flatan2
    $flsinh
    $flcosh
    $fltanh
    $flasinh
    $flacosh
    $flatanh
    $flexp
    $fllog		$fllog2
    $flexpm1
    $fllog1p
    $flexpt
    $flsquare
    $flcube
    $flsqrt
    $flcbrt
    $flhypot

;;; --------------------------------------------------------------------

    $make-cflonum
    $cflonum-real
    $cflonum-imag
    $make-compnum
    $compnum-real
    $compnum-imag

;;; --------------------------------------------------------------------

    $make-bytevector
    $bytevector-length
    $bytevector-empty?
    $bytevector-not-empty?
    $bytevector-u8-last-index
    $bytevector-u8-ref
    $bytevector-s8-ref
    $bytevector-u8-set!
    $bytevector-s8-set!
    $bytevector-ieee-double-native-ref
    $bytevector-ieee-double-native-set!
    $bytevector-ieee-single-native-ref
    $bytevector-ieee-single-native-set!
    $bytevector-ieee-single-nonnative-ref
    $bytevector-ieee-single-nonnative-set!
    $bytevector-ieee-double-nonnative-set!
    $bytevector-ieee-double-nonnative-ref

    $bytevector-u16b-ref
    $bytevector-u16b-set!
    $bytevector-u16l-ref
    $bytevector-u16l-set!
    $bytevector-s16b-ref
    $bytevector-s16b-set!
    $bytevector-s16l-ref
    $bytevector-s16l-set!
    $bytevector-u16n-ref
    $bytevector-u16n-set!
    $bytevector-s16n-ref
    $bytevector-s16n-set!

    $bytevector-u16-ref
    $bytevector-u16-set!

    $bytevector-u32b-ref
    $bytevector-u32b-set!
    $bytevector-u32l-ref
    $bytevector-u32l-set!
    $bytevector-s32b-ref
    $bytevector-s32b-set!
    $bytevector-s32l-ref
    $bytevector-s32l-set!
    $bytevector-u32n-ref
    $bytevector-u32n-set!
    $bytevector-s32n-ref
    $bytevector-s32n-set!

    $bytevector-u64b-ref
    $bytevector-u64b-set!
    $bytevector-u64l-ref
    $bytevector-u64l-set!
    $bytevector-s64b-ref
    $bytevector-s64b-set!
    $bytevector-s64l-ref
    $bytevector-s64l-set!
    $bytevector-u64n-ref
    $bytevector-u64n-set!
    $bytevector-s64n-ref
    $bytevector-s64n-set!

    $bytevector=
    $bytevector-fill!
    ;;FIXME To be  uncommented at the next boot  image rotation.  (Marco
    ;;Maggi; Tue Nov 26, 2013)
    #;$bytevector-copy
    $bytevector-copy!
    $bytevector-copy!/count
    $bytevector-self-copy-forwards!
    $bytevector-self-copy-backwards!
    $subbytevector-u8

    $bytevector-total-length
    $bytevector-concatenate
    $bytevector-reverse-and-concatenate

    $bytevector->base64
    $base64->bytevector

;;; --------------------------------------------------------------------

    $car
    $cdr
    $set-car!
    $set-cdr!

    $caar
    $cadr
    $cdar
    $cddr

    $caaar
    $caadr
    $cadar
    $cdaar
    $cdadr
    $cddar
    $cdddr
    $caddr

;;; --------------------------------------------------------------------

    $length
    ;;FIXME To be  uncommented at the next boot  image rotation.  (Marco
    ;;Maggi; Tue Nov 26, 2013)
    #;$map1
    #;$for-each1
    $for-all1
    $exists1

;;; --------------------------------------------------------------------

    $make-vector
    $vector-ref
    $vector-set!
    $vector-length
    $vector-empty?

    $vector-map1
    $vector-for-each1
    $vector-for-all1
    $vector-exists1

    $vector-copy
    $vector-copy!
    $vector-self-copy-forwards!
    $vector-self-copy-backwards!
    $vector-fill!
    $subvector
    $vector-clean!
    $make-clean-vector

;;; --------------------------------------------------------------------

    $char=
    $char<
    $char>
    $char>=
    $char<=
    $char->fixnum

    $char-is-single-char-line-ending?
    $char-is-carriage-return?
    $char-is-newline-after-carriage-return?

;;; --------------------------------------------------------------------

    $make-string
    $string-length
    $string-empty?
    $string-not-empty?
    $string-last-index
    $string-ref
    $string-set!
    $string=
    $string
    $uri-encoded-string?
    $percent-encoded-string?

    $string-copy
    $string-copy!
    $string-copy!/count
    $string-self-copy-forwards!
    $string-self-copy-backwards!
    $string-fill!
    $substring

    $string-total-length
    $string-concatenate
    $string-reverse-and-concatenate

    ;;FIXME To be  uncommented at the next boot  image rotation.  (Marco
    ;;Maggi; Tue Nov 26, 2013)
    #;$string->octets
    #;$octets->string
    #;$octets-encoded-bytevector?

    $string->ascii
    $ascii->string
    $ascii-encoded-bytevector?
    $ascii-encoded-string?

    $string->latin1
    $latin1->string
    $latin1-encoded-bytevector?
    $latin1-encoded-string?

    $string-base64->bytevector
    $bytevector->string-base64

    $uri-encode
    $uri-decode
    $uri-normalise-encoding
    $uri-encoded-bytevector?
    $percent-encode
    $percent-decode
    $percent-normalise-encoding
    $percent-encoded-bytevector?

;;; --------------------------------------------------------------------

    $string-hash
    $string-ci-hash
    $symbol-hash
    $bytevector-hash

;;; --------------------------------------------------------------------

    $pointer?
    $pointer=

;;; --------------------------------------------------------------------

    $memory-block-pointer
    $memory-block-size

;;; --------------------------------------------------------------------

    $closure-code
    $code->closure
    $code-reloc-vector
    $code-freevars
    $code-size
    $code-annotation
    $code-ref
    $code-set!
    $set-code-annotation!

    #| end of export |# )
  (import (ikarus)
    (ikarus system $structs)
    (except (ikarus system $fx)
	    $fxmax
	    $fxmin
	    $fx<
	    $fx>
	    $fx>=
	    $fx<=
	    $fx=)
    (prefix (only (ikarus system $fx)
		  $fx<
		  $fx>
		  $fx>=
		  $fx<=
		  $fx=)
	    sys.)
    (ikarus system $bignums)
    (ikarus system $ratnums)
    (ikarus system $flonums)
    (ikarus system $compnums)
    (ikarus system $pairs)
    (vicare system $lists)
    (ikarus system $vectors)
    (rename (ikarus system $bytevectors)
	    ($bytevector-set!	$bytevector-set!)
	    ($bytevector-set!	$bytevector-u8-set!)
	    ($bytevector-set!	$bytevector-s8-set!))
    (ikarus system $chars)
    (ikarus system $strings)
    (ikarus system $codes)
    (ikarus system $pointers)
    (vicare system $hashtables)
    (for (prefix (only (vicare platform configuration)
		       platform-endianness)
		 config.)
	 expand))


;;;; structures

(define-syntax $struct-length
  (syntax-rules ()
    ((_ ?stru)
     ($struct-ref ($struct-rtd ?stru) 1))))

;;; --------------------------------------------------------------------

(define-syntax $memory-block-pointer
  (syntax-rules ()
    ((_ ?stru)
     ($struct-ref ?stru 0))))

(define-syntax $memory-block-size
  (syntax-rules ()
    ((_ ?stru)
     ($struct-ref ?stru 1))))


;;;; pairs

(define-inline ($caar x)	($car ($car x)))
(define-inline ($cadr x)	($car ($cdr x)))
(define-inline ($cdar x)	($cdr ($car x)))
(define-inline ($cddr x)	($cdr ($cdr x)))

(define-inline ($caaar x)	($car ($car ($car x))))
(define-inline ($caadr x)	($car ($car ($cdr x))))
(define-inline ($cadar x)	($car ($cdr ($car x))))
(define-inline ($cdaar x)	($cdr ($car ($car x))))
(define-inline ($cdadr x)	($cdr ($car ($cdr x))))
(define-inline ($cddar x)	($cdr ($cdr ($car x))))
(define-inline ($cdddr x)	($cdr ($cdr ($cdr x))))
(define-inline ($caddr x)	($car ($cdr ($cdr x))))


;;;; fixnums

;;; arithmetic operations

(define-syntax $fxneg
  (syntax-rules ()
    ((_ ?op)
     ($fx- 0 ?op))))

;;; --------------------------------------------------------------------

(define-syntax $fxadd2
  (syntax-rules ()
    ((_ ?op)
     ($fx+ ?op 2))))

(define-syntax $fxadd3
  (syntax-rules ()
    ((_ ?op)
     ($fx+ ?op 3))))

(define-syntax $fxadd4
  (syntax-rules ()
    ((_ ?op)
     ($fx+ ?op 4))))

(define-syntax $fxincr!
  (syntax-rules ()
    ((_ ?op)
     ($fxincr! ?op 1))
    ((_ ?op 0)
     ?op)
    ((_ ?op 1)
     (set! ?op ($fxadd1 ?op)))
    ((_ ?op 2)
     (set! ?op ($fxadd2 ?op)))
    ((_ ?op 3)
     (set! ?op ($fxadd3 ?op)))
    ((_ ?op 4)
     (set! ?op ($fxadd4 ?op)))
    ((_ ?op ?N)
     (set! ?op ($fx+ ?op ?N)))
    ))

;;; --------------------------------------------------------------------

(define-syntax $fxsub2
  (syntax-rules ()
    ((_ ?op)
     ($fx- ?op 2))))

(define-syntax $fxsub3
  (syntax-rules ()
    ((_ ?op)
     ($fx- ?op 3))))

(define-syntax $fxsub4
  (syntax-rules ()
    ((_ ?op)
     ($fx- ?op 4))))

(define-syntax $fxdecr!
  (syntax-rules ()
    ((_ ?op)
     ($fxdecr! ?op 1))
    ((_ ?op 0)
     ?op)
    ((_ ?op 1)
     (set! ?op ($fxsub1 ?op)))
    ((_ ?op 2)
     (set! ?op ($fxsub2 ?op)))
    ((_ ?op 3)
     (set! ?op ($fxsub3 ?op)))
    ((_ ?op 4)
     (set! ?op ($fxsub4 ?op)))
    ((_ ?op ?N)
     (set! ?op ($fx+ ?op ?N)))
    ))

;;; --------------------------------------------------------------------

(define-syntax $fxmax
  (syntax-rules ()
    ((_ ?op)
     ?op)
    ((_ ?op1 ?op2)
     (let ((a ?op1)
	   (b ?op2))
       (if ($fx>= a b) a b)))
    ((_ ?op1 ?op2 . ?ops)
     (let ((X ($fxmax ?op1 ?op2)))
       ($fxmax X . ?ops)))
    ))

(define-syntax $fxmin
  (syntax-rules ()
    ((_ ?op)
     ?op)
    ((_ ?op1 ?op2)
     (let ((a ?op1)
	   (b ?op2))
       (if ($fx<= a b) a b)))
    ((_ ?op1 ?op2 . ?ops)
     (let ((X ($fxmin ?op1 ?op2)))
       ($fxmin X . ?ops)))
    ))

;;; --------------------------------------------------------------------
;;; logic operations

(define-syntax $fxand
  (syntax-rules ()
    ((_ ?op1)
     ?op1)
    ((_ ?op1 ?op2)
     ($fxlogand ?op1 ?op2))
    ((_ ?op1 ?op2 . ?ops)
     ($fxlogand ?op1 ($fxand ?op2 . ?ops)))))

(define-syntax $fxior
  (syntax-rules ()
    ((_ ?op1)
     ?op1)
    ((_ ?op1 ?op2)
     ($fxlogor ?op1 ?op2))
    ((_ ?op1 ?op2 . ?ops)
     ($fxlogor ?op1 ($fxior ?op2 . ?ops)))))

(define-syntax $fxxor
  (syntax-rules ()
    ((_ ?op1)
     ?op1)
    ((_ ?op1 ?op2)
     ($fxlogxor ?op1 ?op2))
    ((_ ?op1 ?op2 . ?ops)
     ($fxlogxor ?op1 ($fxxor ?op2 . ?ops)))))

;;; --------------------------------------------------------------------

(let-syntax ((define-fx-compar (syntax-rules ()
				  ((_ ?proc sys.?proc)
				   (define-syntax ?proc
				    (syntax-rules ()
				      ((_ ?op1 ?op2)
				       (sys.?proc ?op1 ?op2))
				      ((_ ?op1 ?op2 ?op3 ?op4 (... ...))
				       (let ((op2 ?op2))
					 (and (sys.?proc ?op1 op2)
					      (?proc op2 ?op3 ?op4 (... ...))))))))
				 )))
  (define-fx-compar $fx=  sys.$fx=)
  (define-fx-compar $fx<  sys.$fx<)
  (define-fx-compar $fx<= sys.$fx<=)
  (define-fx-compar $fx>  sys.$fx>)
  (define-fx-compar $fx>= sys.$fx>=))


;;;; bignums

(define-syntax-rule (%bnbncmp X Y fxcmp)
  (fxcmp (foreign-call "ikrt_bnbncomp" X Y) 0))

(define-syntax-rule ($bnbn= X Y)
  (%bnbncmp X Y $fx=))

(define-syntax-rule ($bnbn< X Y)
  (%bnbncmp X Y $fx<))

(define-syntax-rule ($bnbn> X Y)
  (%bnbncmp X Y $fx>))

(define-syntax-rule ($bnbn<= X Y)
  (%bnbncmp X Y $fx<=))

(define-syntax-rule ($bnbn>= X Y)
  (%bnbncmp X Y $fx>=))


;;;; heterogeneous and high-level operations

(define-inline (fx+fx X Y)
  (foreign-call "ikrt_fxfxplus" X Y))

(define-inline (fx+bn X Y)
  (foreign-call "ikrt_fxbnplus" X Y))

(define-inline (bn+bn X Y)
  (foreign-call "ikrt_bnbnplus" X Y))

;;; --------------------------------------------------------------------

(define-inline (fx-fx X Y)
  (foreign-call "ikrt_fxfxminus" X Y))

(define-inline (fx-bn X Y)
  (foreign-call "ikrt_fxbnminus" X Y))

(define-inline (bn-bn X Y)
  (foreign-call "ikrt_bnbnminus" X Y))

;;; --------------------------------------------------------------------

(define-inline (fx-and-bn X Y)
  (foreign-call "ikrt_fxbnlogand" X Y))

(define-inline (bn-and-bn X Y)
  (foreign-call "ikrt_bnbnlogand" X Y))

(define-inline (fx-ior-bn X Y)
  (foreign-call "ikrt_fxbnlogor" X Y))

(define-inline (bn-ior-bn X Y)
  (foreign-call "ikrt_bnbnlogor" X Y))


;;;; unsafe 16-bit setters and getters
;;
;;            |            | lowest memory | highest memory
;; endianness |    word    | location      | location
;; -----------+------------+---------------+--------------
;;   little   |   #xHHLL   |     LL        |     HH
;;    big     |   #xHHLL   |     HH        |      LL
;;
;;
;;NOTE  Remember that  $BYTEVECTOR-SET! takes  care of  storing in
;;memory only the least significant byte of its value argument.
;;

(define-inline ($bytevector-u16l-ref bv index)
  ($fxlogor
   ;; highest memory location -> most significant byte
   ($fxsll ($bytevector-u8-ref bv ($fxadd1 index)) 8)
   ;; lowest memory location -> least significant byte
   ($bytevector-u8-ref bv index)))

(define-inline ($bytevector-u16l-set! bv index word)
  ;; lowest memory location -> least significant byte
  ($bytevector-set! bv index word)
  ;; highest memory location -> most significant byte
  ($bytevector-set! bv ($fxadd1 index) (fxsra word 8)))

;;; --------------------------------------------------------------------

(define-inline ($bytevector-u16b-ref bv index)
  ($fxlogor
   ;; lowest memory location -> most significant byte
   ($fxsll ($bytevector-u8-ref bv index) 8)
   ;; highest memory location -> least significant byte
   ($bytevector-u8-ref bv ($fxadd1 index))))

(define-inline ($bytevector-u16b-set! bv index word)
  ;; lowest memory location -> most significant byte
  ($bytevector-set! bv index ($fxsra word 8))
  ;; highest memory location -> least significant byte
  ($bytevector-set! bv ($fxadd1 index) word))

;;; --------------------------------------------------------------------

(define-inline ($bytevector-s16l-ref bv index)
  ($fxlogor
   ;; highest memory location -> most significant byte
   ($fxsll ($bytevector-s8-ref bv ($fxadd1 index)) 8)
   ;; lowest memory location -> least significant byte
   ($bytevector-u8-ref bv index)))

(define-inline ($bytevector-s16l-set! bv index word)
  ;; lowest memory location -> least significant byte
  ($bytevector-set! bv index word)
  ;; highest memory location -> most significant byte
  ($bytevector-set! bv ($fxadd1 index) (fxsra word 8)))

;;; --------------------------------------------------------------------

(define-inline ($bytevector-s16b-ref bv index)
  ($fxlogor
   ;; lowest memory location -> most significant byte
   ($fxsll ($bytevector-s8-ref bv index) 8)
   ;; highest memory location -> least significant byte
   ($bytevector-u8-ref bv ($fxadd1 index))))

(define-inline ($bytevector-s16b-set! bv index word)
  ;; lowest memory location -> most significant byte
  ($bytevector-set! bv index ($fxsra word 8))
  ;; highest memory location -> least significant byte
  ($bytevector-set! bv ($fxadd1 index) word))

;;; --------------------------------------------------------------------

(define-syntax $bytevector-u16n-ref
  (case config.platform-endianness
    ((big)
     (identifier-syntax $bytevector-u16b-ref))
    ((little)
     (identifier-syntax $bytevector-u16l-ref))))

(define-syntax $bytevector-u16n-set!
  (case config.platform-endianness
    ((big)
     (identifier-syntax $bytevector-u16b-set!))
    ((little)
     (identifier-syntax $bytevector-u16l-set!))))

;;; --------------------------------------------------------------------

(define-syntax $bytevector-s16n-ref
  (case config.platform-endianness
    ((big)
     (identifier-syntax $bytevector-s16b-ref))
    ((little)
     (identifier-syntax $bytevector-s16l-ref))))

(define-syntax $bytevector-s16n-set!
  (case config.platform-endianness
    ((big)
     (identifier-syntax $bytevector-s16b-set!))
    ((little)
     (identifier-syntax $bytevector-s16l-set!))))

;;; --------------------------------------------------------------------

(define-inline ($bytevector-u16-ref bv index endianness)
  ;;Like BYTEVECTOR-U16-REF  defined by R6RS.  Assume  all the arguments
  ;;to  have been  already validated;  expect the  index integers  to be
  ;;fixnums.
  ;;
  (if (eq? endianness 'big)
      ($bytevector-u16b-ref bv index)
    ($bytevector-u16l-ref bv index)))

(define-inline ($bytevector-u16-set! bv index word endianness)
  ;;Like BYTEVECTOR-U16-SET!  defined by R6RS.  Assume all the arguments
  ;;to  have been  already validated;  expect the  index integers  to be
  ;;fixnums.
  ;;
  (if (eq? endianness 'big)
      ($bytevector-u16b-set! bv index word)
    ($bytevector-u16l-set! bv index word)))


;;;; unsafe 32-bit setters and getters
;;
;;                           lowest memory ------------> highest memory
;; endianness |    word    | 1st byte | 2nd byte | 3rd byte | 4th byte |
;; -----------+------------+----------+----------+----------+-----------
;;   little   | #xAABBCCDD |   DD     |    CC    |    BB    |    AA
;;    big     | #xAABBCCDD |   AA     |    BB    |    CC    |    DD
;; bit offset |            |    0     |     8    |    16    |    24
;;
;;NOTE  Remember that  $BYTEVECTOR-SET! takes  care of  storing in
;;memory only the least significant byte of its value argument.
;;

(define-inline ($bytevector-u32b-ref bv index)
  (+ (sll ($bytevector-u8-ref bv index) 24)
     ($fxior
      ($fxsll ($bytevector-u8-ref bv ($fxadd1 index)) 16)
      ($fxsll ($bytevector-u8-ref bv ($fx+ index 2))  8)
      ($bytevector-u8-ref bv ($fx+ index 3)))))

(define-inline ($bytevector-u32b-set! bv index word)
  (let ((b (sra word 16)))
    ($bytevector-set! bv index ($fxsra b 8))
    ($bytevector-set! bv ($fxadd1 index) b))
  (let ((b (bitwise-and word #xFFFF)))
    ($bytevector-set! bv ($fx+ index 2) ($fxsra b 8))
    ($bytevector-set! bv ($fx+ index 3) b)))

;;; --------------------------------------------------------------------

(define-inline ($bytevector-u32l-ref bv index)
  (+ (sll ($bytevector-u8-ref bv ($fx+ index 3)) 24)
     ($fxior
      ($fxsll ($bytevector-u8-ref bv ($fx+ index 2)) 16)
      ($fxsll ($bytevector-u8-ref bv ($fxadd1 index)) 8)
      ($bytevector-u8-ref bv index))))

(define-inline ($bytevector-u32l-set! bv index word)
  (let ((b (sra word 16)))
    ($bytevector-set! bv ($fx+ index 3) ($fxsra b 8))
    ($bytevector-set! bv ($fx+ index 2) b))
  (let ((b (bitwise-and word #xFFFF)))
    ($bytevector-set! bv ($fxadd1 index) ($fxsra b 8))
    ($bytevector-set! bv index b)))

;;; --------------------------------------------------------------------

(define-inline ($bytevector-s32b-ref bv index)
  (+ (sll ($bytevector-s8-ref bv index) 24)
     ($fxior
      ($fxsll ($bytevector-u8-ref bv ($fxadd1 index))   16)
      ($fxsll ($bytevector-u8-ref bv ($fx+    index 2))  8)
      ($bytevector-u8-ref bv ($fx+ index 3)))))

(define-inline ($bytevector-s32b-set! bv index word)
  (let ((b (sra word 16)))
    ($bytevector-set! bv index ($fxsra b 8))
    ($bytevector-set! bv ($fxadd1 index) b))
  (let ((b (bitwise-and word #xFFFF)))
    ($bytevector-set! bv ($fx+ index 2) ($fxsra b 8))
    ($bytevector-set! bv ($fx+ index 3) b)))

;;; --------------------------------------------------------------------

(define-inline ($bytevector-s32l-ref bv index)
  (+ (sll ($bytevector-s8-ref bv ($fx+ index 3)) 24)
     ($fxior
      ($fxsll ($bytevector-u8-ref bv ($fx+    index 2)) 16)
      ($fxsll ($bytevector-u8-ref bv ($fxadd1 index))    8)
      ($bytevector-u8-ref bv index))))

(define-inline ($bytevector-s32l-set! bv index word)
  (let ((b (sra word 16)))
    ($bytevector-set! bv ($fx+ index 3) ($fxsra b 8))
    ($bytevector-set! bv ($fx+ index 2) b))
  (let ((b (bitwise-and word #xFFFF)))
    ($bytevector-set! bv ($fxadd1 index) ($fxsra b 8))
    ($bytevector-set! bv index b)))

;;; --------------------------------------------------------------------

(define-syntax $bytevector-u32n-ref
  (case config.platform-endianness
    ((big)
     (identifier-syntax $bytevector-u32b-ref))
    ((little)
     (identifier-syntax $bytevector-u32l-ref))))

(define-syntax $bytevector-u32n-set!
  (case config.platform-endianness
    ((big)
     (identifier-syntax $bytevector-u32b-set!))
    ((little)
     (identifier-syntax $bytevector-u32l-set!))))

;;; --------------------------------------------------------------------

(define-syntax $bytevector-s32n-ref
  (case config.platform-endianness
    ((big)
     (identifier-syntax $bytevector-s32b-ref))
    ((little)
     (identifier-syntax $bytevector-s32l-ref))))

(define-syntax $bytevector-s32n-set!
  (case config.platform-endianness
    ((big)
     (identifier-syntax $bytevector-s32b-set!))
    ((little)
     (identifier-syntax $bytevector-s32l-set!))))


;;;; unsafe 64-bit setters and getters
;;
;;                                      lowest memory ------------> highest memory
;; endianness |         word        | 1st | 2nd | 3rd | 4th | 5th | 6th | 7th | 8th |
;; -----------+---------------------+-----+-----+-----+-----+-----+-----+-----+-----|
;;   little   | #xAABBCCDD EEFFGGHH | HH  | GG  | FF  | EE  | DD  | CC  | BB  | AA
;;    big     | #xAABBCCDD EEFFGGHH | AA  | BB  | CC  | DD  | EE  | FF  | GG  | HH
;; bit offset |                     |  0  |  8  | 16  | 24  | 32  | 40  | 48  | 56
;;
;;NOTE  Remember that  $BYTEVECTOR-SET! takes  care of  storing in
;;memory only the least significant byte of its value argument.
;;

(define-inline ($bytevector-u64b-ref ?bv ?index)
  (let ((index ?index))
    (let next-byte ((bv     ?bv)
		    (index  index)
		    (end    ($fx+ index 7))
		    (word   0))
      (let ((word (+ word ($bytevector-u8-ref bv index))))
	(if ($fx= index end)
	    word
	  (next-byte bv ($fxadd1 index) end (sll word 8)))))))

(define-inline ($bytevector-u64b-set! ?bv ?index ?word)
  (let ((index  ?index)
	(word	?word))
    (let next-byte ((bv     ?bv)
		    (index  ($fx+ 7 index))
		    (end    index)
		    (word   word))
      ($bytevector-u8-set! bv index (bitwise-and word #xFF))
      (unless ($fx= index end)
	(next-byte bv ($fxsub1 index) end (sra word 8))))))

;;; --------------------------------------------------------------------

(define-inline ($bytevector-u64l-ref ?bv ?end)
  (let ((end ?end))
    (let next-byte ((bv     ?bv)
		    (index  ($fx+ 7 end))
		    (word   0))
      (let ((word (+ word ($bytevector-u8-ref bv index))))
	(if ($fx= index end)
	    word
	  (next-byte bv ($fxsub1 index) (sll word 8)))))))

(define-inline ($bytevector-u64l-set! ?bv ?index ?word)
  (let ((index	?index)
	(word	?word))
    (let next-byte ((bv     ?bv)
		    (index  index)
		    (end    ($fx+ 7 index))
		    (word   word))
      ($bytevector-u8-set! bv index (bitwise-and word #xFF))
      (unless ($fx= index end)
	(next-byte bv ($fxadd1 index) end (sra word 8))))))

;;; --------------------------------------------------------------------

(define-inline ($bytevector-s64b-ref ?bv ?index)
  (let ((bv	?bv)
	(index	?index))
    (let next-byte ((bv     bv)
		    (index  ($fxadd1 index))
		    (end    ($fx+ index 7))
		    (word   (sll ($bytevector-s8-ref bv index) 8)))
      (let ((word (+ word ($bytevector-u8-ref bv index))))
	(if ($fx= index end)
	    word
	  (next-byte bv ($fxadd1 index) end (sll word 8)))))))

(define-inline ($bytevector-s64b-set! ?bv ?index ?word)
  (let ((index	?index)
	(word	?word))
    (let next-byte ((bv     ?bv)
		    (index  ($fx+ 7 index))
		    (end    index)
		    (word   word))
      (if ($fx= index end)
	  ($bytevector-s8-set! bv index (bitwise-and word #xFF))
	(begin
	  ($bytevector-u8-set! bv index (bitwise-and word #xFF))
	  (next-byte bv ($fxsub1 index) end (sra word 8)))))))

;;; --------------------------------------------------------------------

(define-inline ($bytevector-s64l-ref ?bv ?end)
  (let ((bv	?bv)
	(end	?end))
    (let next-byte ((bv     bv)
		    (index  ($fx+ 6 end))
		    (word   (sll ($bytevector-s8-ref bv ($fx+ 7 end)) 8)))
      (let ((word (+ word ($bytevector-u8-ref bv index))))
	(if ($fx= index end)
	    word
	  (next-byte bv ($fxsub1 index) (sll word 8)))))))

(define-inline ($bytevector-s64l-set! ?bv ?index ?word)
  (let ((index	?index)
	(word	?word))
    (let next-byte ((bv     ?bv)
		    (index  index)
		    (end    ($fx+ 7 index))
		    (word   word))
      (if ($fx= index end)
	  ($bytevector-s8-set! bv index (bitwise-and word #xFF))
	(begin
	  ($bytevector-u8-set! bv index (bitwise-and word #xFF))
	  (next-byte bv ($fxadd1 index) end (sra word 8)))))))

;;; --------------------------------------------------------------------

(define-syntax $bytevector-u64n-ref
  (case config.platform-endianness
    ((big)
     (identifier-syntax $bytevector-u64b-ref))
    ((little)
     (identifier-syntax $bytevector-u64l-ref))))

(define-syntax $bytevector-u64n-set!
  (case config.platform-endianness
    ((big)
     (identifier-syntax $bytevector-u64b-set!))
    ((little)
     (identifier-syntax $bytevector-u64l-set!))))

;;; --------------------------------------------------------------------

(define-syntax $bytevector-s64n-ref
  (case config.platform-endianness
    ((big)
     (identifier-syntax $bytevector-s64b-ref))
    ((little)
     (identifier-syntax $bytevector-s64l-ref))))

(define-syntax $bytevector-s64n-set!
  (case config.platform-endianness
    ((big)
     (identifier-syntax $bytevector-s64b-set!))
    ((little)
     (identifier-syntax $bytevector-s64l-set!))))


;;;; miscellaneous bytevector operations

;;Commented out because implemented by the boot image.
;;
;; (define-inline ($bytevector-empty? ?bv)
;;   ($fxzero? ($bytevector-length ?bv)))

(define-inline ($bytevector-not-empty? ?bv)
  (not ($bytevector-empty? ?bv)))

(define-inline ($bytevector-u8-last-index bv)
  ;;To be called only if BV is not empty!!!
  ($fxsub1 ($bytevector-length bv)))

(define-inline ($bytevector-fill! ?bv ?index ?end ?fill)
  ;;Fill the  positions in ?BV  from ?INDEX inclusive to  ?END exclusive
  ;;with ?FILL.
  ;;
  (let loop ((bv ?bv) (index ?index) (end ?end) (fill ?fill))
    (if ($fx= index end)
	bv
      (begin
	($bytevector-u8-set! bv index fill)
	(loop bv ($fxadd1 index) end fill)))))

(define-inline ($bytevector-copy! ?src.bv ?src.start
				  ?dst.bv ?dst.start
				  ?src.end)
  ;;Copy  the octets of  ?SRC.BV from  ?SRC.START inclusive  to ?SRC.END
  ;;exclusive, to ?DST.BV starting at ?DST.START inclusive.
  ;;
  (let loop ((src.bv ?src.bv) (src.start ?src.start)
	     (dst.bv ?dst.bv) (dst.start ?dst.start)
	     (src.end ?src.end))
    (if ($fx= src.start src.end)
	dst.bv
      (begin
	($bytevector-u8-set! dst.bv dst.start ($bytevector-u8-ref src.bv src.start))
	(loop src.bv ($fxadd1 src.start)
	      dst.bv ($fxadd1 dst.start)
	      src.end)))))

(define-inline ($bytevector-copy!/count ?src.bv ?src.start ?dst.bv ?dst.start ?count)
  ;;Copy ?COUNT octets from  ?SRC.BV starting at ?SRC.START inclusive to
  ;;?DST.BV starting at ?DST.START inclusive.
  ;;
  (let ((src.end ($fx+ ?src.start ?count)))
    ($bytevector-copy! ?src.bv ?src.start
		       ?dst.bv ?dst.start
		       src.end)))

(define-inline ($bytevector-self-copy-forwards! ?bv ?src.start ?dst.start ?count)
  ;;Copy ?COUNT  octets of ?BV  from ?SRC.START inclusive to  ?BV itself
  ;;starting at ?DST.START inclusive.   The copy happens forwards, so it
  ;;is suitable for the case ?SRC.START > ?DST.START.
  ;;
  (let loop ((bv	?bv)
	     (src.start	?src.start)
	     (dst.start	?dst.start)
	     (src.end	($fx+ ?src.start ?count)))
    (unless ($fx= src.start src.end)
      ($bytevector-u8-set! bv dst.start ($bytevector-u8-ref bv src.start))
      (loop bv ($fxadd1 src.start) ($fxadd1 dst.start) src.end))))

(define-inline ($bytevector-self-copy-backwards! ?bv ?src.start ?dst.start ?count)
  ;;Copy ?COUNT  octets of ?BV  from ?SRC.START inclusive to  ?BV itself
  ;;starting at ?DST.START inclusive.  The copy happens backwards, so it
  ;;is suitable for the case ?SRC.START < ?DST.START.
  ;;
  (let loop ((bv	?bv)
	     (src.start	($fx+ ?src.start ?count))
	     (dst.start	($fx+ ?dst.start ?count))
	     (src.end	?src.start))
    (unless ($fx= src.start src.end)
      (let ((src.start ($fxsub1 src.start))
	    (dst.start ($fxsub1 dst.start)))
	($bytevector-u8-set! bv dst.start ($bytevector-u8-ref bv src.start))
	(loop bv src.start dst.start src.end)))))

(define-inline ($subbytevector-u8 src.bv src.start src.end)
  (let* ((dst.len ($fx- src.end src.start))
	 (dst.bv  ($make-bytevector dst.len)))
    (do ((dst.index 0         ($fxadd1 dst.index))
	 (src.index src.start ($fxadd1 src.index)))
	(($fx= dst.index dst.len)
	 dst.bv)
      ($bytevector-u8-set! dst.bv dst.index ($bytevector-u8-ref src.bv src.index)))))


;;;; miscellaneous string operations

;;Commented out because implemented by the boot image.
;;
;; (define-inline ($string-empty? vec)
;;   ($fxzero? ($string-length vec)))

(define-inline ($string-not-empty? ?bv)
  (not ($string-empty? ?bv)))

(define-inline ($string-last-index str)
  ;;To be called only if BV is not empty!!!
  ($fxsub1 ($string-length str)))

(define-inline ($string-fill! ?str ?index ?end ?fill)
  ;;Fill the positions  in ?STR from ?INDEX inclusive  to ?END exclusive
  ;;with ?FILL.
  ;;
  (let loop ((str ?str) (index ?index) (end ?end) (fill ?fill))
    (if ($fx= index end)
	str
      (begin
	($string-set! str index fill)
	(loop str ($fxadd1 index) end fill)))))

(define-inline ($string-copy ?src.str)
  (let* ((src.len ($string-length ?src.str))
	 (dst.str ($make-string src.len)))
    ($string-copy! ?src.str 0 dst.str 0 src.len)))

(define-inline ($string-copy! ?src.str ?src.start
			      ?dst.str ?dst.start
			      ?src.end)
  ;;Copy  the  characters  of  ?SRC.STR  from  ?SRC.START  inclusive  to
  ;;?SRC.END exclusive, to ?DST.STR starting at ?DST.START inclusive.
  ;;
  (let loop ((src.str ?src.str) (src.start ?src.start)
	     (dst.str ?dst.str) (dst.start ?dst.start)
	     (src.end ?src.end))
    (if ($fx= src.start src.end)
	dst.str
      (begin
	($string-set! dst.str dst.start ($string-ref src.str src.start))
	(loop src.str ($fxadd1 src.start)
	      dst.str ($fxadd1 dst.start)
	      src.end)))))

(define-inline ($string-copy!/count ?src.str ?src.start ?dst.str ?dst.start ?count)
  ;;Copy  ?COUNT   characters  from  ?SRC.STR   starting  at  ?SRC.START
  ;;inclusive to ?DST.STR starting at ?DST.START inclusive.
  ;;
  (let ((src.end ($fx+ ?src.start ?count)))
    ($string-copy! ?src.str ?src.start
		   ?dst.str ?dst.start
		   src.end)))

(define-inline ($string-self-copy-forwards! ?str ?src.start ?dst.start ?count)
  ;;Copy  ?COUNT characters of  ?STR from  ?SRC.START inclusive  to ?STR
  ;;itself starting at ?DST.START inclusive.  The copy happens forwards,
  ;;so it is suitable for the case ?SRC.START > ?DST.START.
  ;;
  (let loop ((str	?str)
	     (src.start	?src.start)
	     (dst.start	?dst.start)
	     (src.end	($fx+ ?src.start ?count)))
    (unless ($fx= src.start src.end)
      ($string-set! str dst.start ($string-ref str src.start))
      (loop str ($fxadd1 src.start) ($fxadd1 dst.start) src.end))))

(define-inline ($string-self-copy-backwards! ?str ?src.start ?dst.start ?count)
  ;;Copy  ?COUNT characters of  ?STR from  ?SRC.START inclusive  to ?STR
  ;;itself   starting  at  ?DST.START   inclusive.   The   copy  happens
  ;;backwards, so it is suitable for the case ?SRC.START < ?DST.START.
  ;;
  (let loop ((str	?str)
	     (src.start	($fx+ ?src.start ?count))
	     (dst.start	($fx+ ?dst.start ?count))
	     (src.end	?src.start))
    (unless ($fx= src.start src.end)
      (let ((src.start ($fxsub1 src.start))
	    (dst.start ($fxsub1 dst.start)))
	($string-set! str dst.start ($string-ref str src.start))
	(loop str src.start dst.start src.end)))))

(define-inline ($substring ?str ?start ?end)
  ;;Return  a  new  string  holding  characters from  ?STR  from  ?START
  ;;inclusive to ?END exclusive.
  ;;
  (let ((dst.len ($fx- ?end ?start)))
    (if ($fx< 0 dst.len)
	(let ((dst.str ($make-string dst.len)))
	  ($string-copy! ?str ?start dst.str 0 ?end)
	  dst.str)
      "")))


;;;; miscellaneous vector operations

(define-inline ($make-clean-vector ?len)
  (let* ((len ?len)
	 (vec ($make-vector ?len)))
    ($vector-clean! vec)))

;;Commented out because implemented by the boot image.
;;
;; (define-inline ($vector-empty? vec)
;;   ($fxzero? ($vector-length vec)))

(define-inline ($vector-clean! ?vec)
  (foreign-call "ikrt_vector_clean" ?vec))

(define-inline ($vector-fill! ?vec ?index ?end ?fill)
  ;;Fill the positions  in ?VEC from ?INDEX inclusive  to ?END exclusive
  ;;with ?FILL.
  ;;
  (let loop ((vec ?vec) (index ?index) (end ?end) (fill ?fill))
    (if ($fx= index end)
	vec
      (begin
	($vector-set! vec index fill)
	(loop vec ($fxadd1 index) end fill)))))

(define-inline ($vector-copy ?vec)
  (let* ((src.vec ?vec)
	 (src.len ($vector-length src.vec))
	 (dst.vec ($make-vector src.len)))
    ($vector-copy! src.vec 0 dst.vec 0 src.len)
    dst.vec))

(define-inline ($vector-copy! ?src.vec ?src.start
			      ?dst.vec ?dst.start
			      ?src.end)
  ;;Copy  the items of  ?SRC.VEC from  ?SRC.START inclusive  to ?SRC.END
  ;;exclusive, to ?DST.VEC starting at ?DST.START inclusive.
  ;;
  (let loop ((src.vec ?src.vec) (src.start ?src.start)
	     (dst.vec ?dst.vec) (dst.start ?dst.start)
	     (src.end ?src.end))
    (if ($fx= src.start src.end)
	dst.vec
      (begin
	($vector-set! dst.vec dst.start ($vector-ref src.vec src.start))
	(loop src.vec ($fxadd1 src.start)
	      dst.vec ($fxadd1 dst.start)
	      src.end)))))

(define-inline ($vector-self-copy-forwards! ?vec ?src.start ?dst.start ?count)
  ;;Copy ?COUNT items  of ?VEC from ?SRC.START inclusive  to ?VEC itself
  ;;starting at ?DST.START inclusive.   The copy happens forwards, so it
  ;;is suitable for the case ?SRC.START > ?DST.START.
  ;;
  (let loop ((vec	?vec)
	     (src.start	?src.start)
	     (dst.start	?dst.start)
	     (src.end	($fx+ ?src.start ?count)))
    (unless ($fx= src.start src.end)
      ($vector-set! vec dst.start ($vector-ref vec src.start))
      (loop vec ($fxadd1 src.start) ($fxadd1 dst.start) src.end))))

(define-inline ($vector-self-copy-backwards! ?vec ?src.start ?dst.start ?count)
  ;;Copy ?COUNT items  of ?VEC from ?SRC.START inclusive  to ?VEC itself
  ;;starting at ?DST.START inclusive.  The copy happens backwards, so it
  ;;is suitable for the case ?SRC.START < ?DST.START.
  ;;
  (let loop ((vec	?vec)
	     (src.start	($fx+ ?src.start ?count))
	     (dst.start	($fx+ ?dst.start ?count))
	     (src.end	?src.start))
    (unless ($fx= src.start src.end)
      (let ((src.start ($fxsub1 src.start))
	    (dst.start ($fxsub1 dst.start)))
	($vector-set! vec dst.start ($vector-ref vec src.start))
	(loop vec src.start dst.start src.end)))))

(define-inline ($subvector ?vec ?start ?end)
  ;;Return a new vector holding items from ?VEC from ?START inclusive to
  ;;?END exclusive.
  ;;
  (let ((dst.len ($fx- ?end ?start)))
    (if ($fx< 0 dst.len)
	(let ((dst.vec ($make-vector dst.len)))
	  ($vector-copy! ?vec ?start dst.vec 0 ?end)
	  dst.vec)
      '#())))


;;;; characters

;;; Line endings
;;
;;R6RS defines  the following standalone and sequences  of characters as
;;line endings:
;;
;;   #\x000A		linefeed
;;   #\x000D		carriage return
;;   #\x0085		next line
;;   #\x2028		line separator
;;   #\x000D #\000A	carriage return + linefeed
;;   #\x000D #\0085	carriage return + next line
;;
;;to  process line  endings  from a  textual  input port,  we should  do
;;something like this:
;;
;; (let ((ch (read-char port)))
;;   (cond ((eof-object? ch)
;;          (handle-eof))
;;         (($char-is-single-char-line-ending? ch)
;;          (handle-ending ch))
;;         (($char-is-carriage-return? ch)
;;          (let ((ch1 (peek-char port)))
;;            (cond ((eof-object? ch1)
;;                   (handle-ending ch))
;;                  (($char-is-newline-after-carriage-return? ch1)
;;                   (read-char port)
;;                   (handle-ending ch ch1))
;;                  (else
;;                   (handle-ending ch))))
;;         (else
;;          (handle-other-char ch)))))
;;

(define-inline ($char-is-single-char-line-ending? ch)
  (or ($fx= ch #\x000A)	  ;linefeed
      ($fx= ch #\x0085)	  ;next line
      ($fx= ch #\x2028))) ;line separator

(define-inline ($char-is-carriage-return? ch)
  ($fx= ch #\xD))

(define-inline ($char-is-newline-after-carriage-return? ch)
  ;;This is used to recognise 2-char newline sequences.
  ;;
  (or ($fx= ch #\x000A)	  ;linefeed
      ($fx= ch #\x0085))) ;next line


;;;; done

)

;;; end of file
