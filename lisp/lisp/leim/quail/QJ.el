;; Quail package `chinese-qj
;;   Generated by the command `titdic-convert'
;;	Original TIT dictionary file: QJ.tit

;; # -*- coding: euc-china -*-
;; # HANZI input table for cxterm
;; # To be used by cxterm, convert me to .cit format first
;; # .cit version 2
;; ENCODE:	GB
;; AUTOSELECT:	YES
;; PROMPT:	���������ȫ�ǡ�
;; #
;; COMMENT Copyright 1991 by Yongguang Zhang.      (ygz@cs.purdue.edu)
;; COMMENT Permission to use/modify/copy for any purpose is hereby granted.
;; COMMENT Absolutely no warranties.
;; # define keys
;; VALIDINPUTKEY:	\040!"\043$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMN
;; VALIDINPUTKEY:	OPQRSTUVWXYZ[\134]^_`abcdefghijklmnopqrstuvwxyz{|}~
;; # the following line must not be removed
;; BEGINDICTIONARY

;;; End of the header of original TIT dictionary.

;;; Code:

(require 'quail)

(quail-define-package "chinese-qj" "Chinese-GB" "ȫG"
 t
"���������ȫ�ǡ�

 Copyright 1991 by Yongguang Zhang.      (ygz@cs.purdue.edu)
 Permission to use/modify/copy for any purpose is hereby granted.
 Absolutely no warranties.
"
 '(("\C-?" . quail-delete-last-char)
   
   ("." . quail-next-translation)
   (">" . quail-next-translation)
   ("," . quail-prev-translation)
   ("<" . quail-prev-translation))
 nil nil nil nil)

(quail-define-rules
(" " "��")
("!" "��")
("\"" "��")
("#" "��")
("$" "��")
("%" "��")
("&" "��")
("'" "��")
("(" "��")
(")" "��")
("*" "��")
("+" "��")
("," "��")
("-" "��")
("." "��")
("/" "��")
("0" "��")
("1" "��")
("2" "��")
("3" "��")
("4" "��")
("5" "��")
("6" "��")
("7" "��")
("8" "��")
("9" "��")
(":" "��")
(";" "��")
("<" "��")
("=" "��")
(">" "��")
("?" "��")
("@" "��")
("A" "��")
("B" "��")
("C" "��")
("D" "��")
("E" "��")
("F" "��")
("G" "��")
("H" "��")
("I" "��")
("J" "��")
("K" "��")
("L" "��")
("M" "��")
("N" "��")
("O" "��")
("P" "��")
("Q" "��")
("R" "��")
("S" "��")
("T" "��")
("U" "��")
("V" "��")
("W" "��")
("X" "��")
("Y" "��")
("Z" "��")
("[" "��")
("\\" "��")
("]" "��")
("^" "��")
("_" "��")
("`" "��")
("a" "��")
("b" "��")
("c" "��")
("d" "��")
("e" "��")
("f" "��")
("g" "��")
("h" "��")
("i" "��")
("j" "��")
("k" "��")
("l" "��")
("m" "��")
("n" "��")
("o" "��")
("p" "��")
("q" "��")
("r" "��")
("s" "��")
("t" "��")
("u" "��")
("v" "��")
("w" "��")
("x" "��")
("y" "��")
("z" "��")
("{" "��")
("|" "��")
("}" "��")
("~" "��")
)
;; Local Variables:
;; version-control: never
;; no-update-autoloads: t
;; coding: chinese-iso-8bit-unix
;; End:
